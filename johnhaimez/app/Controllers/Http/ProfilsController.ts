import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Profil from "App/Models/Profil";
import CreateProfilValidator from "App/Validators/CreateProfilValidator";
import UpdateProfilValidator from "App/Validators/UpdateProfilValidator";

export default class ProfilsController {
  // page profil private
  public async displayProfilPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;

      const profil = await Profil.first();
      console.log(profil);

      return view.render("private/profil", { profil, title: "Mon profil" });
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
        // TODO si image creation image

        // create profil
        await Profil.create({ ...payload });
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
