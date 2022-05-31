import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Link from "App/Models/Link";
import LinkValidator from "App/Validators/LinkValidator";
import ImagesController from "./ImagesController";

export default class LinksController {
  public async create(ctx: HttpContextContract) {
    try {
      // validate
      const link = await ctx.request.validate(LinkValidator);

      // si input image
      if (link.imageLink) {
        const image = await ImagesController.create(
          ctx,
          "johnfolio/link/",
          `link-${link.libelle}`,
          "imageLink"
        );

        // si image on creer le link
        if (image) {
          const newLink = await Link.create({
            href: link.href,
            libelle: link.libelle,
          });

          await image.related("imageId").create(newLink);
        }
      }

      return ctx.response.redirect("/private/admin/profil");
    } catch (error) {
      console.log(error);
    }
  }
}
