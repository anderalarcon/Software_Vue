import pool from "../database/keys";

const aunthentication = {};
aunthentication.signUp = async (req, res) => {
  const { nombre, email, password, role } = req.body;

  if (role == "cliente") {
    try {
      await pool.query(
        "INSERT INTO cliente (nombre_cliente,email_cliente,password_cliente)values($1,$2,$3)",
        [nombre, email, password]
      );
      res.status(200).json({
        message: "succesfull registred client",
        client: { nombre, email, password },
      });
    } catch (error) {
      if (error.constraint == "cliente_email_cliente_key") {
        res.status(500).json({
          message: "some1 is already using that email",
          error,
        });
      } else {
        res.status(500).json({
          message: " An error has acurred",
          error,
        });
      }
      res.status(500).json({
        message: " An error has acurred",
        error,
      });
    }
  } else {
    try {
      await pool.query(
        "INSERT INTO proveedor (nombre_proveedor,email_proveedor,password_proveedor)values($1,$2,$3)",
        [nombre, email, password]
      );
      res.status(200).json({
        message: "succesfull registred proveedor",
        proveedor: { nombre, email, password },
      });
    } catch (error) {
      if (error.constraint == "proveedor_email_proveedor_key") {
        res.status(500).json({
          message: "some1 is already using that email",
          error,
        });
      } else {
        res.status(500).json({
          message: " An error has acurred",
          error,
        });
      }
      res.status(500).json({
        message: " An error has acurred",
        error,
      });
    }
  }
};

aunthentication.signIn = async (req, res) => {
  const { email, password, role } = req.body;
  if (role == "cliente") {
    try {
      const cliente = await (
        await pool.query(
          "select * from cliente where email_cliente=$1 and password_cliente=$2",
          [email, password]
        )
      ).rows;
      if (cliente.length > 0) {
        res.status(200).json({
          id: cliente[0].id_cliente,
          nombre: cliente[0].nombre_cliente,
          email: cliente[0].email_cliente,
          role: "cliente",
        });
      } else {
        res.status(200).json({
          message: " Cliente no existe",
          NotFound: true,
        });
      }
    } catch (error) {
      res.status(500).json({
        message: " An error has acurred",
        error,
      });
    }
  } else {
    try {
      const proveedor = await (
        await pool.query(
          "select * from proveedor where email_proveedor=$1 and password_proveedor=$2",
          [email, password]
        )
      ).rows;
      if (proveedor.length > 0) {
        res.status(200).json({
          id: proveedor[0].id_proveedor,
          nombre: proveedor[0].nombre_proveedor,
          email: proveedor[0].email_proveedor,
          role: "proveedor",
        });
      } else {
        res.status(200).json({
          message: " Proveedor no existe",
          NotFound: true,
        });
      }
    } catch (error) {
      res.status(500).json({
        message: " An error has acurred",
        error,
      });
    }
  }
};
module.exports = aunthentication;
