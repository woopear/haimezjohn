import Mail from "@ioc:Adonis/Addons/Mail";
import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Competence from "App/Models/Competence";
import Contact from "App/Models/Contact";
import Hardskill from "App/Models/Hardskill";
import Env from "@ioc:Adonis/Core/Env";
import Image from "App/Models/Image";
import Link from "App/Models/Link";
import Portfolio from "App/Models/Portfolio";
import Profil from "App/Models/Profil";
import Project from "App/Models/Project";
import Softskill from "App/Models/Softskill";

export default class HomeController {
  /**
   * async showHome
   */
  public async showHome({ view }: HttpContextContract) {
    try {
      // get profil
      const profil = await Profil.first();
      let imageProfil = {} as Image | null;
      if (profil?.imageId) {
        imageProfil = await Image.find(profil.imageId);
      }
      // get link
      const links = await Link.query().preload("images");
      // get competence
      const competence = await Competence.first();
      await competence?.load("images");
      // get hardskill
      const hardskills = await Hardskill.query().preload("images");
      // get softskill
      const softskills = await Softskill.query().preload("images");
      // get portfolio
      const portfolio = await Portfolio.first();
      // get project
      const projects = await Project.all();
      // get contact
      const contact = await Contact.first();

      return view.render("home", {
        profil,
        imageProfil,
        competence,
        links,
        softskills,
        hardskills,
        portfolio,
        projects,
        contact,
        title: "John Haimez",
      });
    } catch (error) {
      console.log(error);
    }
  }

  /**
   * sendMailContact
   * envoie d'email de contact à john haimez
   */
  public async sendMailContact({ response, request }: HttpContextContract) {
    const { user, userEmail, userMessage } = request.only([
      "user",
      "userEmail",
      "userMessage",
    ]);

    await Mail.sendLater((message) => {
      message
        .from(Env.get("ADDRESSE_EMAIL_EVOIE_MAIL"))
        .to(`${userEmail}`)
        .subject("Contact site john haimez")
        .htmlView("email/contact", {
          user: user,
          userEmail: userEmail,
          message: userMessage,
        });
    });

    return response.redirect().back();
  }
}
