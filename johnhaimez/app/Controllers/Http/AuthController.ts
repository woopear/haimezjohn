import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";
import User from "App/Models/User";

export default class AuthController {
  /**
   * showLogin
   * affiche la page de connexion admin du site
   */
  public async showLogin({ view, auth, response }: HttpContextContract) {
    if (auth.user) {
      return response.redirect("private");
    }
    return view.render("connexion", { title: "Connexion admin" });
  }

  /**
   * login
   * endpoint pour le fomulaire de connexion
   * si pas bon retourne message d'erreur
   */
  public async login({ response, auth, request }: HttpContextContract) {
    const { email, password } = request.only(["email", "password"]);
    await auth.attempt(email, password);
    return response.redirect("private");
  }

  /**
   * register
   * creation user, cela créé un user mais ne le connect pas directement
   * car il y aura qu'un utilisateur qui sera le createur du site
   * pour ce connecter cette fois l'utilisateur devra aller sur la page
   * de connexion
   */
  public async register({ request }: HttpContextContract) {
    try {
      const payload = request.only(["email", "password"]);
      await User.create(payload);
      return { state: "succes" };
    } catch (error) {
      console.log(error);
      return { state: "error" };
    }
  }

  /**
   * logout
   * deconnexion du user (session)
   */
  public async logout({ auth, response }: HttpContextContract) {
    await auth.logout();
    return response.redirect("/");
  }
}
