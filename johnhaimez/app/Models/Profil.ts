import { DateTime } from "luxon";
import { BaseModel, beforeSave, column } from "@ioc:Adonis/Lucid/Orm";

export default class Profil extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public firstname: string;

  @column()
  public lastname: string;

  @column()
  public username: string;

  @column()
  public address: string;

  @column()
  public codePost: string;

  @column()
  public city: string;

  @column()
  public tel: string;

  @column()
  public email: string;

  @column()
  public title: string | null;

  @column()
  public description: string | null;

  @column()
  public copyright: string;

  @column()
  public imageId: number | null;

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
