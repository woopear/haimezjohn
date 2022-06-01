import { schema, CustomMessages } from "@ioc:Adonis/Core/Validator";
import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";

export default class UpdateFileValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    name: schema.string({ trim: true }),
    path: schema.string({ trim: true }),
  });

  public messages: CustomMessages = {
    "*": (field) => `${field} est obligatoire`,
  };
}
