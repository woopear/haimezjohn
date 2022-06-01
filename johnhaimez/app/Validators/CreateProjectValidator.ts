import { schema, CustomMessages } from "@ioc:Adonis/Core/Validator";
import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";

export default class CreateProjectValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    title: schema.string({ trim: true }),
    description: schema.string({ trim: true }),
    path: schema.string({ trim: true }),
    githubpath: schema.string({ trim: true }),
  });

  public messages: CustomMessages = {
    "*": (field) => `${field} est obligatoire`,
  };
}
