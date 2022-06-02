import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Competence from "App/Models/Competence";
import Hardskill from "App/Models/Hardskill";
import CreateCompetenceValidator from "App/Validators/CreateCompetenceValidator";

export default class HardskillsController {
  // recupere et affiche les hardskill pour la partie private
  public async displayHardskillPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const hardskills = await Hardskill.all();

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
      const payload = await request.validate(CreateCompetenceValidator);

      if (payload) {
        // Todo gerer les images

        // create
        await Hardskill.create({ ...payload });
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
      const payload = await request.validate(CreateCompetenceValidator);

      if (payload) {
        if (updateHardskill) {
          // TODO gerer les images

          // update
          await updateHardskill.merge({ ...payload }).save();
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

      if (deleteHardskill) {
        await deleteHardskill.delete();
      }

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
