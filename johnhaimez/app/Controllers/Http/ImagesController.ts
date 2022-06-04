import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Drive from "@ioc:Adonis/Core/Drive";
import Application from "@ioc:Adonis/Core/Application";
import Env from "@ioc:Adonis/Core/Env";
import Image from "App/Models/Image";

export default class ImagesController {
  // ajoute une image
  public static async addImage(
    ctx: HttpContextContract,
    nameInput: string,
    location: string,
    name?: string
  ) {
    const file = ctx.request.file(nameInput);

    // enregistre sur le disque
    await file?.move(Application.tmpPath(`uploads/${location}`), {
      name: `${name}.${file.extname}`,
    });
    // recupere l'url
    const url = await Drive.getUrl(`/${location}/${name}.${file?.extname}`);

    // creation en bdd
    const newImage = await Image.create({
      name: `${name}.${file?.extname}`,
      path: url,
    });

    // return model image
    return newImage;
  }
}
