import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Profil from 'App/Models/Profil'

export default class ProfilsController {
    // recupere tous les profils et retourne le premier dans la page private profil
    public async getProfilForPrivate({view}: HttpContextContract) {
        try {
            // recupere tous les profils
            const profil = await Profil.first()

            console.log(profil);

            // on retourne la view private profil avec le profil en data
            return view.render('private/pages/profil', {profil, title: 'Profil John Haimez'})
        } catch (error) {
            
        }
    }

    // create profil depuis formulaire et retourne sur la page private profil
    public async createProfil({request, response}: HttpContextContract) {
        try {
            console.log(request.body());
            
            // on creer l'objet profil avec la request
            const newProfil = await Profil.create({...request.body()})
            console.log(newProfil);
            
            // on creer en bdd
            // on retourne sur la page private profil
            return response.redirect('/private/admin/profil')
        } catch (error) {
            
        }
    }
}
