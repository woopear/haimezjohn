import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Image from "App/Models/Image";
import Link from "App/Models/Link";
import CreateLinkValidator from "App/Validators/CreateLinkValidator";
import UpdateLinkValidator from "App/Validators/UpdateLinkValidator";
import ImagesController from "./ImagesController";
import Drive from "@ioc:Adonis/Core/Drive";

export default class LinksController {
  private _nameInput = "fileInput";
  private _location = "links";
  private _nameImage = "link-";

  // affiche les liens dans la page link private
  public async displayLinkPrivate(ctx: HttpContextContract) {
    try {
      // recupere tous les links
      const links = await Link.query().preload("images");

      return ctx.view.render("private/links", { links, title: "Mes liens" });
    } catch (error) {
      console.log(error);
    }
  }

  // create link
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreateLinkValidator);

      if (payload) {
        // creation link en bdd
        const link = await Link.create({ ...payload });

        // si image dans input creation image
        if (request.file(this._nameInput)) {
          const image = await ImagesController.addImage({
            ctx,
            location: this._location,
            nameInput: this._nameInput,
            name: `${this._nameImage}${link.id}`,
          });

          // on relie l'image téléchargé au link créé
          await link.related("images").create(image);
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // modification du lien
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request, params } = ctx;
      let updateLink = await Link.find(params.id);
      await updateLink?.load("images");
      const payload = await request.validate(UpdateLinkValidator);

      if (payload) {
        // si image est deja dans link
        // sinon on créé image
        if (updateLink?.images) {
          // on supprime l'ancien image sur le disk
          await Drive.delete(`${this._location}/${updateLink.images.name}`);
          // on modifie image
          await ImagesController.updateImage({
            ctx,
            image: updateLink?.images,
            location: this._location,
            nameInput: this._nameInput,
            name: `${this._nameImage}${updateLink.id}`,
          });
        } else {
          // si image dans input creation image
          if (request.file(this._nameInput)) {
            const image = await ImagesController.addImage({
              ctx,
              location: this._location,
              nameInput: this._nameInput,
              name: `${this._nameImage}${updateLink?.id}`,
            });

            // on relie l'image téléchargé au link créé
            await updateLink?.related("images").create(image);
          }
        }

        // update link
        if (updateLink) {
          await updateLink.merge({ ...payload }).save();
        }
      }
      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // delete link
  public async deleteOne(ctx: HttpContextContract) {
    try {
      const { response, params } = ctx;
      const deleteLink = await Link.find(params.id);
      await deleteLink?.load("images");

      // si images on supprime les images sur le disk
      // dans la bdd tous est supprimer auto avec option cascade
      if (deleteLink?.images) {
        await ImagesController.deleteImage({
          location: this._location,
          image: deleteLink?.images,
          nameImage: deleteLink?.images.name,
        });
      }

      await deleteLink?.delete();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // delete image
  public async deleteImage(ctx: HttpContextContract) {
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
