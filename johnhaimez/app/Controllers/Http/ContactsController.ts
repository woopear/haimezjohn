import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Contact from "App/Models/Contact";
import CreateContactValidator from "App/Validators/CreateContactValidator";

export default class ContactsController {
  // recupere contact et affiche page contact private
  public async displayContactPrivate(ctx: HttpContextContract) {
    try {
      const contact = await Contact.first();

      return ctx.view.render("private/contact", {
        contact,
        title: "Partie contact",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreateContactValidator);

      await Contact.create({ ...payload });

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const updateContact = await Contact.first();
      const payload = await request.validate(CreateContactValidator);

      await updateContact?.merge({ ...payload }).save();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
