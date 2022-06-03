import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Portfolio from "App/Models/Portfolio";
import CreatePortfolioValidator from "App/Validators/CreatePortfolioValidator";
import UpdatePortfolioValidator from "App/Validators/UpdatePortfolioValidator";

export default class PortfoliosController {
  // recupere le portfolio pour la page private
  public async displayPortfolioPrivate(ctx: HttpContextContract) {
    try {
      const portfolio = await Portfolio.first();

      return ctx.view.render("private/portfolio", {
        portfolio,
        title: "Mon portfolio",
      });
    } catch (error) {
      console.log(error);
    }
  }

  // create
  public async create(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const payload = await request.validate(CreatePortfolioValidator);

      await Portfolio.create({ ...payload });

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }

  // update
  public async update(ctx: HttpContextContract) {
    try {
      const { response, request } = ctx;
      const updatePortfolio = await Portfolio.first();
      const payload = await request.validate(UpdatePortfolioValidator);

      await updatePortfolio?.merge({ ...payload }).save();

      return response.redirect().back();
    } catch (error) {
      console.log(error);
    }
  }
}
