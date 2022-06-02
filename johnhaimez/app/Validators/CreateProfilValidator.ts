import { schema, CustomMessages, rules } from "@ioc:Adonis/Core/Validator";
import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";

export default class CreateProfilValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    firstname: schema.string({ trim: true }),
    lastname: schema.string({ trim: true }),
    address: schema.string({ trim: true }),
    codePost: schema.string({ trim: true }),
    city: schema.string({ trim: true }),
    tel: schema.string({ trim: true }),
    email: schema.string({ trim: true }, [rules.email()]),
    title: schema.string.nullableAndOptional({ trim: true }),
    description: schema.string.nullableAndOptional({ trim: true }),
    copyright: schema.string({ trim: true }),
  });

  public messages: CustomMessages = {
    "*": (field) => `${field} est obligatoire`,
  };
}
