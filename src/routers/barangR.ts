import express from "express";
import { getAllBarang,createBarang,updateBarang, deleteBarang, changePicture } from "../controllers/barangC";
import { verifyAddBarang,verifyUpdateBarang } from "../middlewares/verifyBarang";
import uploadFileBarang from "../middlewares/uploadPicture";
import { verifyRole, verifyToken } from "../middlewares/authorization";

const app = express()
app.use(express.json())

app.get(`/`,[verifyToken,verifyRole(["admin","pelanggan"])],getAllBarang)
app.post(`/create`,[verifyToken,verifyRole(["admin"]),verifyAddBarang],createBarang)
app.put(`/update/:id`,[verifyToken,verifyRole(["admin"]),verifyUpdateBarang],updateBarang)
app.delete(`/delete/:id`,[verifyToken,verifyRole(["admin"])],deleteBarang)
app.put(`/pic/:id`,[verifyToken,verifyRole(["admin"])],uploadFileBarang.single("picture"),changePicture)

export default app  