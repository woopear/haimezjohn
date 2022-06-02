import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Competence from "App/Models/Competence";
import CreateCompetenceValidator from "App/Validators/CreateCompetenceValidator";
import UpdateCompetenceValidator from "App/Validators/UpdateCompetenceValidator";

export default class CompetencesController {
  // affiche la competence partie priver
  public async displayCompetencePrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const competence = await Competence.first();

      return view.render("private/competence", {
        competence,
        title: "Partie competence",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // creation competence
  public async create(ctx: HttpContextContract) {
    try {
      const { request, response } = ctx;
      const payload = await request.validate(CreateCompetenceValidator);

      if (payload) {
        // TODO gerer le file

        // creation competence
        await Competence.create({ ...payload });
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // modification competence
  public async update(ctx: HttpContextContract) {
    try {
      const { request, response } = ctx;
      const updateCompetence = await Competence.first();
      const payload = await request.validate(UpdateCompetenceValidator);

      if (payload) {
        // TODO gerer le file

        // modification de la competence
        if (updateCompetence) {
          await updateCompetence.merge({ ...payload }).save();
        }
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
