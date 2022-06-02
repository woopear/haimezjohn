import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Profil from "App/Models/Profil";

export default class ProfilsController {
  // page profil private
  public async displayProfil(ctx: HttpContextContract) {
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
      const { response } = ctx;

      return response.redirect("private/profil");
    } catch (error) {
      console.log(error);
    }
  }

  // update profil
  public async update(ctx: HttpContextContract) {
    try {
      const { response } = ctx;

      return response.redirect("private/profil");
    } catch (error) {
      console.log(error);
    }
  }
}
