import Route from "@ioc:Adonis/Core/Route";
import LinksController from "App/Controllers/Http/LinksController";

// accueil
Route.get("/", async ({ view }) => {
  return view.render("home", { title: "John Haimez" });
});

// route private
Route.group(() => {
  // accueil admin
  Route.get("/admin", async ({ view }) => {
    return view.render("private/admin_home", { title: "Admin John haimez" });
  });

  // route admin
  Route.group(() => {
    // profil
    Route.group(() => {
      Route.get("/", "ProfilsController.getProfilForPrivate");
      Route.post("/create", "ProfilsController.createProfil");
      Route.post("/update/:id", "ProfilsController.updateProfil");
      Route.get(
        "/deleteavatar/:id",
        "ProfilsController.deleteImageProfilAvatar"
      );
      Route.get("/deleteimage/:id", "ProfilsController.deleteImageProfilImage");
      Route.post("/link/create", "LinksController.create");
    }).prefix("/profil");

    // competences // TODO faire un groupe de competences pour inclure toute les routes
    Route.get("/competences", async ({ view }) => {
      return view.render("private/pages/competences", {
        title: "Admin Profil John Haimez",
      });
    });

    // portfolio // TODO faire un groupe de portfolio pour inclure toute les routes
    Route.get("/portfolio", async ({ view }) => {
      return view.render("private/pages/portfolio", {
        title: "Admin Profil John Haimez",
      });
    });

    // conditions_generales // TODO faire un groupe de conditions_generales pour inclure toute les routes
    Route.get("/conditions_generales", async ({ view }) => {
      return view.render("private/pages/conditions_generales", {
        title: "Admin Profil John Haimez",
      });
    });

    // mentions_legales // TODO faire un groupe de mentions_legales pour inclure toute les routes
    Route.get("/mentions_legales", async ({ view }) => {
      return view.render("private/pages/mentions_legales", {
        title: "Admin Profil John Haimez",
      });
    });
  }).prefix("/admin");
}).prefix("/private");
