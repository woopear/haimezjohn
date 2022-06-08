import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Drive from "@ioc:Adonis/Core/Drive";
import Application from "@ioc:Adonis/Core/Application";
import Image from "App/Models/Image";

export default class ImagesController {
  // ajoute une image
  public static async addImage(option: {
    ctx: HttpContextContract;
    nameInput: string;
    location: string;
    name?: string;
  }) {
    const file = option.ctx.request.file(option.nameInput);

    // enregistre sur le disque dans le dossier public/uploads/"location"
    await file?.move(Application.publicPath(`uploads/${option.location}`), {
      name: `${option.name}.${file.extname}`,
    });
    // recupere l'url
    const url = await Drive.getUrl(
      `/${option.location}/${option.name}.${file?.extname}`
    );

    // creation en bdd
    const newImage = await Image.create({
      name: `${option.name}.${file?.extname}`,
      path: url,
    });

    // return model image
    return newImage;
  }

  // ajoute plusieurs image en meme temps
  public static async addManyImage(option: {
    ctx: HttpContextContract;
    nameInput: string;
    location: string;
  }): Promise<Image[]> {
    const files = option.ctx.request.files(option.nameInput);
    let tabImages: Image[] = [];

    for (const file of files) {
      // enregistre sur le disque dans le dossier public/uploads/"location"
      await file?.move(Application.publicPath(`uploads/${option.location}`));
      // recupere l'url
      const url = await Drive.getUrl(`/${option.location}/${file.fileName}`);

      // creation en bdd
      const newImage = await Image.create({
        name: `${file.fileName}`,
        path: url,
      });

      tabImages.push(newImage);
    }

    return tabImages;
  }

  // update image
  public static async updateImage(options: {
    ctx: HttpContextContract;
    nameInput: string;
    location: string;
    image: Image;
    name?: string;
  }) {
    const file = options.ctx.request.file(options.nameInput);

    // enregistre sur le disque
    await file?.move(Application.publicPath(`uploads/${options.location}`), {
      name: `${options.name}.${file.extname}`,
      overwrite: true,
    });

    // recupere l'url
    const url = await Drive.getUrl(
      `/${options.location}/${options.name}.${file?.extname}`
    );

    // on modifie l'image
    await options.image
      .merge({
        name: `${options.name}.${file?.extname}`,
        path: url,
      })
      .save();
  }

  // delete image
  public static async deleteImage(options: {
    location: string;
    nameImage: string;
    image: Image;
  }) {
    // supprime ancienne image
    await Drive.delete(`${options.location}/${options.nameImage}`);
    // supprime image dans bdd
    await options.image.delete();
  }
}
