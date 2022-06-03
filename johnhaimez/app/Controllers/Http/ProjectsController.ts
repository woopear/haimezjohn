import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Project from "App/Models/Project";
import CreateProjectValidator from "App/Validators/CreateProjectValidator";
import UpdateProjectValidator from "App/Validators/UpdateProjectValidator";

export default class ProjectsController {
  // recupere tous les project et affiche project privat
  public async displayProjectPrivate(ctx: HttpContextContract) {
    try {
      const projects = await Project.all();

      return ctx.view.render("private/projects", {
        projects,
        title: "Mes project",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreateProjectValidator);

      await Project.create({ ...payload });

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request, params } = ctx;
      const updateProject = await Project.find(params.id);
      const payload = await request.validate(UpdateProjectValidator);

      await updateProject?.merge({ ...payload }).save();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // delete
  public async delete(ctx: HttpContextContract) {
    try {
      const { response, params } = ctx;
      const updateProject = await Project.find(params.id);

      await updateProject?.delete();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
