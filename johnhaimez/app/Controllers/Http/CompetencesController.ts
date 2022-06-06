import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Competence from "App/Models/Competence";
import CreateCompetenceValidator from "App/Validators/CreateCompetenceValidator";
import UpdateCompetenceValidator from "App/Validators/UpdateCompetenceValidator";
import ImagesController from "./ImagesController";
import Drive from "@ioc:Adonis/Core/Drive";
import Image from "App/Models/Image";

export default class CompetencesController {
  private _nameInput = "fileInput";
  private _location = "cvcompetence";
  private _nameFile = "competencecv";

  // affiche la competence partie priver
  public async displayCompetencePrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const competence = await Competence.first();
      await competence?.load("images");

      return view.render("private/competence", {
        competence,
        title: "Partie competence",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // creation competence
  public async create(ctx: HttpContextContract) {
    try {
      const { request, response } = ctx;
      const payload = await request.validate(CreateCompetenceValidator);

      if (payload) {
        // creation competence
        const competence = await Competence.create({ ...payload });

        // si image dans input creation image
        if (request.file(this._nameInput)) {
          const image = await ImagesController.addImage({
            ctx,
            location: this._location,
            nameInput: this._nameInput,
            name: `${this._nameFile}`,
          });

          // on relie l'image téléchargé au link créé
          await competence.related("images").create(image);
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // modification competence
  public async update(ctx: HttpContextContract) {
    try {
      const { request, response } = ctx;
      const updateCompetence = await Competence.first();
      await updateCompetence?.load("images");
      const payload = await request.validate(UpdateCompetenceValidator);

      if (payload) {
        // si image est deja créer
        // sinon on créer image
        if (updateCompetence?.images) {
          // on supprime l'ancien image sur le disk
          await Drive.delete(
            `${this._location}/${updateCompetence.images.name}`
          );
          // on modifie image
          await ImagesController.updateImage({
            ctx,
            image: updateCompetence?.images,
            location: this._location,
            nameInput: this._nameInput,
            name: `${this._nameFile}`,
          });
        } else {
          // si image dans input creation image
          if (request.file(this._nameInput)) {
            const image = await ImagesController.addImage({
              ctx,
              location: this._location,
              nameInput: this._nameInput,
              name: `${this._nameFile}`,
            });

            // on relie l'image téléchargé au link créé
            await updateCompetence?.related("images").create(image);
          }
        }

        // modification de la competence
        if (updateCompetence) {
          await updateCompetence.merge({ ...payload }).save();
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // delete cv
  public async deleteFile(ctx: HttpContextContract) {
    try {
      const { response, params } = ctx;
      const image = await Image.find(params.id);

      // si image existe on delete
      if (image) {
        await ImagesController.deleteImage({
          image: image,
          location: this._location,
          nameImage: image?.name,
        });
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
