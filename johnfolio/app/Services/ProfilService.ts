import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Env from "@ioc:Adonis/Core/Env";
import Profil from "App/Models/Profil";
import ProfilValidator from "App/Validators/ProfilValidator";

export default class ProfilService {
  // validation et upload image à la creation du profil
  public static async validateAndUploadImageForCreate({
    request,
  }: HttpContextContract): Promise<Profil> {
    const pathImage = "johnfolio/profil/";
    const nameAvatar = "avatar";
    const nameImage = "imgprofil";
    let newProfil = {} as Profil;
    const payload = await request.validate(ProfilValidator);

    // test si avatar et fait les traitements
    if (payload.avatarFile != null) {
      await payload.avatarFile.moveToDisk(
        pathImage,
        { name: `${nameAvatar}.${payload.avatarFile.extname}` },
        payload.avatarFile.size > 1000 ? "s3" : undefined
      );
      newProfil.avatar = `${Env.get("S3_URL_IMAGE")}${pathImage}${nameAvatar}.${
        payload.avatarFile.extname
      }`;
    }

    // test si image et fait les traitements
    if (payload.profilFile != null) {
      await payload.profilFile.moveToDisk(
        pathImage,
        { name: `${nameImage}.${payload.profilFile.extname}` },
        payload.profilFile.size > 1000 ? "s3" : undefined
      );
      newProfil.image = `${Env.get("S3_URL_IMAGE")}${pathImage}${nameImage}.${
        payload.profilFile.extname
      }`;
    }

    // on construit l'objet profil
    newProfil = { ...newProfil, ...request.body() };

    return newProfil;
  }
}
