import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Hardskill from "App/Models/Hardskill";
import CreateCompetenceValidator from "App/Validators/CreateCompetenceValidator";
import UpdateCompetenceValidator from "App/Validators/UpdateCompetenceValidator";

export default class HardskillsController {
  // recupere et affiche les hardskill pour la partie private
  public async displayHardskillPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const hardskills = await Hardskill.all();

      // TODO gerer la recuperation d'image

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

      // create
      await Hardskill.create({ ...payload });

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
      const payload = await request.validate(UpdateCompetenceValidator);

      // update
      await updateHardskill?.merge({ ...payload }).save();

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

      await deleteHardskill?.delete();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // ajouter une image
  public async addImage(ctx: HttpContextContract) {
    try {
      const { response } = ctx;
      // TODO gerer les images
      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update une image
  public async updateImage(ctx: HttpContextContract) {
    try {
      const { response } = ctx;
      // TODO gerer les images
      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // ajouter une image
  public async deleteImage(ctx: HttpContextContract) {
    try {
      const { response } = ctx;
      // TODO gerer les images
      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
