import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Link from "App/Models/Link";
import CreateLinkValidator from "App/Validators/CreateLinkValidator";

export default class LinksController {
  // affiche les liens dans la page link private
  public async displayLinkPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;

      // recupere tous les links
      const links = await Link.all();

      return view.render("private/links", { links, title: "Mes liens" });
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
        // Todo gere l'image creation

        // creation link en bdd
        await Link.create({ ...payload });
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
      const payload = await request.validate(CreateLinkValidator);

      if (payload) {
        // Todo gerer modification image

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
}
