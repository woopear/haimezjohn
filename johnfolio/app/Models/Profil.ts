import { DateTime } from "luxon";
import { BaseModel, beforeSave, column } from "@ioc:Adonis/Lucid/Orm";

export default class Profil extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public firstname: String;

  @column()
  public lastname: String;

  @column()
  public email: String;

  @column()
  public username: String;

  @column()
  public address: String;

  @column()
  public codePost: String;

  @column()
  public city: String;

  @column()
  public avatar: String | null;

  @column()
  public image: String | null;

  @column()
  public tel: String;

  @column()
  public copyright: String;

  @column()
  public title: String;

  @column()
  public description: String;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;

  @beforeSave()
  public static createUsername(profil: Profil) {
    if (profil.$dirty.firstname && profil.$dirty.lastname) {
      profil.username = `${profil.firstname} ${profil.lastname}`;
    }
  }
}
