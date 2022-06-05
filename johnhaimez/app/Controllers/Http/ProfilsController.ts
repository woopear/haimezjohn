import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Image from "App/Models/Image";
import Profil from "App/Models/Profil";
import CreateProfilValidator from "App/Validators/CreateProfilValidator";
import UpdateProfilValidator from "App/Validators/UpdateProfilValidator";
import ImagesController from "./ImagesController";
import Drive from "@ioc:Adonis/Core/Drive";

export default class ProfilsController {
  private _location = "profil";
  private _nameImage = "profil_image";

  // page profil private
  public async displayProfilPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      let imageProfil = {} as Image | null;
      let profil = await Profil.first();

      if (profil) {
        imageProfil = await Image.find(profil.imageId);
      }

      return view.render("private/profil", {
        profil,
        imageProfil,
        title: "Mon profil",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create profil
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      let payload = await request.validate(CreateProfilValidator);

      if (payload) {
        // si input image on créer image
        if (request.file("profilImage")) {
          const _image = await ImagesController.addImage({
            ctx,
            nameInput: "profilImage",
            location: this._location,
            name: this._nameImage,
          });

          // create profil
          const profil = await Profil.create({ ...payload });
          // on affecte id image au profil
          await _image.related("profil").create(profil);
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update profil
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request, params } = ctx;
      let updateProfil = await Profil.find(params.id);
      let imageProfil = await Image.find(updateProfil?.imageId);
      let payload = await request.validate(UpdateProfilValidator);

      if (payload) {
        // si input image
        if (request.file("profilImage")) {
          // si le profil a deja une image
          if (imageProfil) {
            // supprime ancienne image
            await Drive.delete(`${this._location}/${imageProfil.name}`);

            // modifie image
            await ImagesController.updateImage({
              ctx,
              nameInput: "profilImage",
              location: this._location,
              image: imageProfil,
              name: this._nameImage,
            });
          } else {
            // create image
            const _newImage = await ImagesController.addImage({
              ctx,
              nameInput: "profilImage",
              location: this._location,
              name: this._nameImage,
            });

            // on affecte id image au profil
            if (updateProfil) {
              await _newImage.related("profil").create(updateProfil);
            }
          }
        }

        // update profil
        if (updateProfil) {
          await updateProfil.merge({ ...payload }).save();
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // TODO delete image
}
