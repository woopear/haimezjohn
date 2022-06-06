import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Image from "App/Models/Image";
import Softskill from "App/Models/Softskill";
import CreateSoftskillValidator from "App/Validators/CreateSoftskillValidator";
import UpdateSoftskillValidator from "App/Validators/UpdateSoftskillValidator";
import ImagesController from "./ImagesController";

export default class SoftskillsController {
  private _nameInput = "fileInput";
  private _location = "softskills";

  // recupere la list des soft skill pour private
  public async displaySoftskillPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const softskills = await Softskill.query().preload("images");

      return view.render("private/softskills", {
        softskills,
        title: "Soft skill",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreateSoftskillValidator);

      // create
      const softskill = await Softskill.create({ ...payload });

      // si fileInput on creer et affecte les nouvelles image
      if (request.files("fileInput")) {
        const images = await ImagesController.addManyImage({
          ctx,
          nameInput: this._nameInput,
          location: this._location,
        });

        for (const image of images) {
          await softskill.related("images").create(image);
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request, params } = ctx;
      const updateSoftskill = await Softskill.find(params.id);
      const payload = await request.validate(UpdateSoftskillValidator);

      // update
      await updateSoftskill?.merge({ ...payload }).save();

      // si fileInput on creer et affecte les nouvelles image
      if (request.files("fileInput")) {
        const images = await ImagesController.addManyImage({
          ctx,
          nameInput: this._nameInput,
          location: this._location,
        });

        for (const image of images) {
          await updateSoftskill?.related("images").create(image);
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // delete
  public async delete(ctx: HttpContextContract) {
    try {
      const { response, params } = ctx;
      const deleteSoftskill = await Softskill.find(params.id);
      await deleteSoftskill?.load("images");

      // si images on supprime les images sur le disk
      // dans la bdd tous est supprimer auto avec option cascade
      if (deleteSoftskill?.images) {
        for (const image of deleteSoftskill.images) {
          await ImagesController.deleteImage({
            location: this._location,
            image: image,
            nameImage: image.name,
          });
        }
      }

      await deleteSoftskill?.delete();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // supprimer une image
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
