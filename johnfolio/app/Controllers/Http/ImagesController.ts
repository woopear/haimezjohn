import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Drive from "@ioc:Adonis/Core/Drive";
import Env from "@ioc:Adonis/Core/Env";
import Image from "App/Models/Image";
import { schema } from "@ioc:Adonis/Core/Validator";

export default class ImagesController {
  public static async create(
    ctx: HttpContextContract,
    location: string,
    nameImageBdd: string,
    nameInput: string
  ): Promise<Image | null> {
    try {
      // validatate input image
      const inputImage = await ctx.request.validate({
        schema: schema.create({
          [nameInput]: schema.file.nullableAndOptional({
            extnames: ["png", "jpg", "jepg"],
            size: "10mb",
          }),
        }),
      });

      // si validation input
      if (inputImage) {
        if (inputImage[nameInput]) {
          // enregistrement s3
          const s3 = Drive.use("s3");
          await s3.put(location, ctx.request.input(nameInput), {
            name: `${nameImageBdd}.${inputImage[nameInput]!.extname}`,
          });

          // enregistrement bdd
          const newImage = await Image.create({
            name: nameImageBdd,
            location: location,
            path: `${Env.get("S3_URL_IMAGE")}${location}${nameImageBdd}.${
              inputImage[nameInput]!.extname
            }`,
          });
          // return model image créé
          return newImage;
        }
      }
    } catch (error) {
      console.log(error);
    }
    return null;
  }

  public static async update(
    idImage: number,
    ctx: HttpContextContract,
    location: string,
    nameInput: string
  ): Promise<Image | null> {
    try {
      // on recupere l'image
      const image = await Image.find(idImage);
      //on delete ancienne image
      if (image) {
        if (image.location) {
          const s3 = Drive.use("s3");
          await s3.delete(image.location);
          image.location = "";
          image.path = "";
          await image.save();
        }

        // validatate input image
        const inputImage = await ctx.request.validate({
          schema: schema.create({
            [nameInput]: schema.file.nullableAndOptional({
              extnames: ["png", "jpg", "jepg"],
              size: "10mb",
            }),
          }),
        });

        // si validate
        if (inputImage) {
          if (inputImage[nameInput]) {
            // enregistrement s3
            const s3 = Drive.use("s3");
            await s3.put(location, ctx.request.input(nameInput), {
              name: `${image.name}.${inputImage[nameInput]!.extname}`,
            });

            // modification image
            await image
              .merge({
                location: location,
                path: `${Env.get("S3_URL_IMAGE")}${location}${image.name}.${
                  inputImage[nameInput]!.extname
                }`,
              })
              .save();
          }
        }

        return image;
      }
    } catch (error) {
      console.log(error);
    }
    return null;
  }

  public static async delete(idImage: number): Promise<void> {
    try {
      // on recupere l'image
      const image = await Image.find(idImage);
      // on delete sur s3
      if (image) {
        if (image.location) {
          // on delete dans s3
          const s3 = Drive.use("s3");
          await s3.delete(image.location);
          // on delete en bdd
          await image.delete();
        }
      }
    } catch (error) {
      console.log(error);
    }
  }
}
