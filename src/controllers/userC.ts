import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { v4 as uuidv4 } from "uuid";
import { BASE_URL,SECRET } from "../global";
import fs from "fs";
import md5  from "md5";
import { sign } from "jsonwebtoken";

const prisma = new PrismaClient({ errorFormat: "pretty" });

export const getAlluser = async (request: Request, response: Response) => {
  try {
    const { search } = request.query;
    const alluser = await prisma.user.findMany({
      where: { nama: { contains: search?.toString() || "" } },
    });
    return response
      .json({
        status: true,
        data: alluser,
        message: `user has retrieved`,
      })
      .status(200);
  } catch (error) {
    return response
      .json({
        status: false,
        message: `There is an error. ${error}`,
      })
      .status(400);
  }
};

export const createuser = async (request: Request, response: Response) => {
  try {
    const { id,nama,kontak, alamat, username,role, email, password,  } = request.body;
    const uuid = uuidv4();

    const newuser = await prisma.user.create({
      data: { uuid,id,nama,kontak, alamat,username,role,email, password:md5(password) },
    });

    return response
      .json({
        status: true,
        data: newuser,
        message: `New user has created`,
      })
      .status(200);
  } catch (error) {
    return response
      .json({
        status: false,
        message: `There is an error. ${error}`,
      })
      .status(400);
  }
};

export const updateuser = async (request: Request, response: Response) => {
  try {
    const { id } = request.params;
    const { Iduser,nama,kontak, alamat, username,role, email, password,  } = request.body;

    const finduser = await prisma.user.findFirst({
      where: { id: Number(id) },
    });
    if (!finduser)
      return response
        .status(200)
        .json({ status: false, message:`user is not found` });

    const updateuser = await prisma.user.update({
      data: {
        id:finduser.id,
        nama:finduser.nama,
        kontak:finduser.kontak,
        alamat:finduser.alamat,
        username:finduser.username,
        role:finduser.role,
        email:finduser.email,
        password:finduser.password
      },
      where: { id: Number(id) },
    });

    return response
      .json({
        status: true,
        data: updateuser,
        message: `user has updated`
      })
      .status(200);
  } catch (error) {
    return response
      .json({
        status: false,
        message: `There is an error. ${error}`,
      })
      .status(400);
  }
};

export const changeProfile = async (request:Request, response:Response)=>{
  try {
      const {id} = request.params
      const finduser = await prisma.user.findFirst({where: {id: Number(id)}})
      if (!finduser)return response 
      .status(200).json({ status: false, massage:`user with id ${id} is not found`})

      /** default value  filename of  saved data*/
      let filename = finduser.profile_picture
      if (request.file) {
          /**update filename by new uploaded picture */
          filename = request.file.filename
          /**check the old picture in the folder */
          let path = `${BASE_URL}/../public/profile_picture/${finduser.profile_picture}`
          let exist = fs.existsSync(path)
          /**delet the old exist picture if reupload new file  */
          if (exist && finduser.profile_picture !==``) fs.unlinkSync(path)
      }

      /**process to update picture  in database */
      const  updateProfile = await prisma.user.update ({
          data:{profile_picture:filename},
          where: {id: Number(id)}
          })
          return response.json({
              status: true,
              data:updateProfile,
              message:`picture has change`
          }).status(200)

  } catch (error) {
      return response.json({
          status: false,
          massage:`There is an error. ${error}`
          }).status(400)
  }                   
}

export const deleteuser = async(request:Request, response:Response) =>{
    try {
        const {id} = request.params
        const finduser = await prisma.user.findFirst({where: {id: Number(id)}})
        if (!finduser)return response 
        .status(200).json({ status: false, massage:`user with id ${id} not found`})
    
        /**check the old picture in the folder */
        let path = `${BASE_URL}/../public/profil_picture/${finduser.profile_picture}`
        let exist = fs.existsSync(path)
        /**delete the old exist picture if reupload new file  */
        if (exist && finduser.profile_picture !==``) fs.unlinkSync(path)

        /**process to delet user's data */
        const result = await prisma.user.delete({
            where:{ id: Number(request.params.id)}
        })
        return response.json({
            status: true,
            data: result,
            massage: `user with id ${id} has been Deleted`
        }).status(200)

    } catch (error) {
        return response.json({
        status: false,
        massage:`There is an error. ${error}`
        })
        .status(400)
    }
}

//AUTHENTIFICATION user
export const authentification = async(request:Request,response:Response) =>{
    try {
        const {email, password} =request.body

        const finduser = await prisma.user.findFirst({
            where: { email,password: md5(password) }
        })
        
        if(!finduser)
        return response
            .status(200)
            .json({
             status: false,
             logged: false,
             message: `Email or password is invalid`
            });

            let data={
                id:finduser.id,
                nama:finduser.nama,
                kontak:finduser.kontak,
                alamat:finduser.alamat,
                email:finduser.email,
                username:finduser.username,
                role:finduser.role
            }

            let payload=JSON.stringify(data)

            let token=sign(payload, SECRET || "token")

            return response
            .status(200)
            .json({status:true, logged: true, message:`Login Success`, token})
            
    } catch (error) {
        return response.json({
            status: false,
            massage:`There is an error. ${error}`
            })
            .status(400)
    }
}

export const createuserpelanggan = async (request: Request, response: Response) => {
  try {
    const { id,nama,kontak, alamat, username,role, email, password,  } = request.body;
    const uuid = uuidv4();

    const newuser = await prisma.user.create({
      data: { uuid,id,nama,kontak, alamat,username,role,email, password:md5(password) },
    });

    return response
      .json({
        status: true,
        data: newuser,
        message: `New user has created`,
      })
      .status(200);
  } catch (error) {
    return response
      .json({
        status: false,
        message: `There is an error. ${error}`,
      })
      .status(400);
  }
};