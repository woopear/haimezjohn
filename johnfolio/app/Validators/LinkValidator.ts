import { schema, CustomMessages } from "@ioc:Adonis/Core/Validator";
import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";

export default class LinkValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    libelle: schema.string({ trim: true }),
    href: schema.string({ trim: true }),
    imageLink: schema.file.nullableAndOptional({
      extnames: ["png", "jpg", "jepg"],
      size: "10mb",
    }),
  });

  public messages: CustomMessages = {
    required: "{{ field }} est obligatoire",
  };
}
