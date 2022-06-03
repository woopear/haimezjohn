import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Softskill from "App/Models/Softskill";
import CreateSoftskillValidator from "App/Validators/CreateSoftskillValidator";
import UpdateSoftskillValidator from "App/Validators/UpdateSoftskillValidator";

export default class SoftskillsController {
  // recupere la list des soft skill pour private
  public async displaySoftskillPrivate(ctx: HttpContextContract) {
    try {
      const { view } = ctx;
      const softskills = await Softskill.all();

      // TODO gerer la recuperation d'image

      return view.render("private/softskills", {
        softskills,
        title: "Soft skill",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreateSoftskillValidator);

      // create
      await Softskill.create({ ...payload });

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request, params } = ctx;
      const updateSoftskill = await Softskill.find(params.id);
      const payload = await request.validate(UpdateSoftskillValidator);

      // update
      await updateSoftskill?.merge({ ...payload }).save();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // delete
  public async delete(ctx: HttpContextContract) {
    try {
      const { response, params } = ctx;
      const deleteSoftskill = await Softskill.find(params.id);

      await deleteSoftskill?.delete();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
