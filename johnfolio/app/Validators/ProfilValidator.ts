import { schema, CustomMessages, rules } from "@ioc:Adonis/Core/Validator";
import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";

export default class ProfilValidator {
  constructor(protected ctx: HttpContextContract) {}
  public schema = schema.create({
    firstname: schema.string({ trim: true }),
    lastname: schema.string({ trim: true }),
    email: schema.string({ trim: true }, [rules.email()]),
    address: schema.string({ trim: true }),
    codePost: schema.string({ trim: true }),
    city: schema.string({ trim: true }),
    tel: schema.string({ trim: true }),
    copyright: schema.string({ trim: true }),
    title: schema.string.nullableAndOptional({ trim: true }),
    description: schema.string.nullableAndOptional({ trim: true }),
    avatarFile: schema.file.nullableAndOptional({
      extnames: ["png", "jpg", "jepg"],
      size: "10mb",
    }),
    profilFile: schema.file.nullableAndOptional({
      extnames: ["png", "jpg", "jepg"],
      size: "10mb",
    }),
  });

  public messages: CustomMessages = {};
}
