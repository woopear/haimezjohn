import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import Profil from "App/Models/Profil";
import ProfilService from "App/Services/ProfilService";
import Drive from "@ioc:Adonis/Core/Drive";
import ProfilValidator from "App/Validators/ProfilValidator";
import Env from "@ioc:Adonis/Core/Env";

export default class ProfilsController {
  // recupere tous les profils et retourne le premier dans la page private profil
  public async getProfilForPrivate({ view }: HttpContextContract) {
    try {
      // recupere tous les profils
      const profil = await Profil.first();

      // on retourne la view private profil avec le profil en data
      return view.render("private/pages/profil", {
        profil,
        title: "Profil John Haimez",
      });
    } catch (error) {}
  }

  // create profil depuis formulaire et retourne sur la page private profil
  public async createProfil(ctx: HttpContextContract) {
    try {
      const newProfil = await ProfilService.validateAndUploadImageForCreate(
        ctx
      );

      // creation du model
      await Profil.create({ ...newProfil });

      // on retourne sur la page private profil
      return ctx.response.redirect("/private/admin/profil");
    } catch (error) {
      console.log(error);
    }
  }

  public async updateProfil(ctx: HttpContextContract) {
    try {
      // creation des variables
      const pathImage = "johnfolio/profil/";
      const nameAvatar = "avatar";
      const nameImage = "imgprofil";
      let newProfil = {} as Profil;

      // on recupere le profil
      const profil = await Profil.find(ctx.params.id);
      // on valide la data request
      const payload = await ctx.request.validate(ProfilValidator);

      // si avatar upload update
      if (payload.avatarFile != null) {
        if (profil) {
          if (profil.avatar) {
            const path = profil.avatar.split("/").slice(3).join("/");
            const s3 = Drive.use("s3");
            await s3.delete(path as string);
            newProfil.avatar = "";
          }
        }
        await payload.avatarFile.moveToDisk(
          pathImage,
          { name: `${nameAvatar}.${payload.avatarFile.extname}` },
          payload.avatarFile.size > 1000 ? "s3" : undefined
        );
        newProfil.avatar = `${Env.get(
          "S3_URL_IMAGE"
        )}${pathImage}${nameAvatar}.${payload.avatarFile.extname}`;
      }

      // si image upload update
      if (payload.profilFile != null) {
        if (profil) {
          if (profil.image) {
            const path = profil.image.split("/").slice(3).join("/");
            const s3 = Drive.use("s3");
            await s3.delete(path as string);
            newProfil.image = "";
          }
        }
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
      newProfil = { ...newProfil, ...ctx.request.body() };

      // update du model
      await profil?.merge({ ...newProfil }).save();

      // on retourne sur la page private profil
      return ctx.response.redirect("/private/admin/profil");
    } catch (error) {
      console.log(error);
    }
  }

  // suppression avatar profil
  public async deleteImageProfilAvatar(ctx: HttpContextContract) {
    try {
      // on recupere le profil
      const profil = await Profil.find(ctx.params.id);

      if (profil) {
        if (profil.avatar) {
          const path = profil.avatar.split("/").slice(3).join("/");
          const s3 = Drive.use("s3");
          await s3.delete(path as string);
          profil.avatar = "";
        }
      }

      // on supprime l'image à l'aide de sont path
      await Profil.create({ ...profil });

      // on retourne sur la page private profil
      return ctx.response.redirect("/private/admin/profil");
    } catch (error) {}
  }

  // suppression image profil
  public async deleteImageProfilImage(ctx: HttpContextContract) {
    try {
      // on recupere le profil
      const profil = await Profil.find(ctx.params.id);

      if (profil) {
        if (profil.image) {
          const path = profil.image.split("/").slice(3).join("/");
          const s3 = Drive.use("s3");
          await s3.delete(path as string);
          profil.image = "";
        }
      }

      // on supprime l'image à l'aide de sont path
      await Profil.create({ ...profil });

      // on retourne sur la page private profil
      return ctx.response.redirect("/private/admin/profil");
    } catch (error) {}
  }
}
