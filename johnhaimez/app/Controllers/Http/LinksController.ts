import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Link from "App/Models/Link";

export default class LinksController {
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
}
