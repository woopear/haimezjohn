import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Hardskill from "App/Models/Hardskill";
import Image from "App/Models/Image";
import CreateHardskillValidator from "App/Validators/CreateHardskillValidator";
import UpdateHardskillValidator from "App/Validators/UpdateHardskillValidator";
import ImagesController from "./ImagesController";

export default class HardskillsController {
  // recupere et affiche les hardskill pour la partie private
  public async displayHardskillPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const hardskills = await Hardskill.query().preload("images");

      return view.render("private/hardskills", {
        hardskills,
        title: "Hard skill",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreateHardskillValidator);

      // create
      const hardskill = await Hardskill.create({ ...payload });

      // si fileInput on creer et affecte les nouvelles image
      if (request.files("fileInput")) {
        const images = await ImagesController.addManyImage({
          ctx,
          nameInput: "fileInput",
          location: "hardskills",
        });

        for (const image of images) {
          await hardskill.related("images").create(image);
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
      const updateHardskill = await Hardskill.find(params.id);
      const payload = await request.validate(UpdateHardskillValidator);

      // update
      await updateHardskill?.merge({ ...payload }).save();

      // si fileInput on creer et affecte les nouvelles image
      if (request.files("fileInput")) {
        const images = await ImagesController.addManyImage({
          ctx,
          nameInput: "fileInput",
          location: "hardskills",
        });

        for (const image of images) {
          await updateHardskill?.related("images").create(image);
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
      const deleteHardskill = await Hardskill.find(params.id);

      // TODO delete tous les images si il y en a
      // TODO voir migration

      await deleteHardskill?.delete();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // ajouter une image
  public async deleteImage(ctx: HttpContextContract) {
    try {
      const { response, params } = ctx;
      const image = await Image.find(params.id);

      // si image existe on delete
      if (image) {
        await ImagesController.deleteImage({
          image: image,
          location: "hardskills",
          nameImage: image?.name,
        });
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
