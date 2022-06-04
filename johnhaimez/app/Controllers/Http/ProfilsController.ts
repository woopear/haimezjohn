import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Image from "App/Models/Image";
import Profil from "App/Models/Profil";
import CreateProfilValidator from "App/Validators/CreateProfilValidator";
import UpdateProfilValidator from "App/Validators/UpdateProfilValidator";
import ImagesController from "./ImagesController";

export default class ProfilsController {
  // page profil private
  public async displayProfilPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      let imageProfil = {} as Image | null;
      let profil = await Profil.first();

      if (profil) {
        const t = await profil.load("profilId");
        console.log(t);
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
        // create profil
        const profil = await Profil.create({ ...payload });

        // si image
        if (request.file("profilImage")) {
          const _image = await ImagesController.addImage(
            ctx,
            "profilImage",
            "profil",
            "profil_image"
          );
          // on affecte id image au profil
          await profil.related("profilId").create(_image);
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
      let payload = await request.validate(UpdateProfilValidator);

      if (payload) {
        // Todo si image update image

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
}
