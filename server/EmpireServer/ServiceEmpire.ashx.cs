using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using Jayrock;
using Jayrock.Json;
using Jayrock.JsonRpc;
using Jayrock.JsonRpc.Web;
using MySql;
using MySql.Data;
using MySql.Web;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace EmpireServer
{
    [JsonRpcService]
    [ToolboxItem(false)]
  
    public class ServiceEmpire : JsonRpcHandler
    {
        private string StringToMD5 (string str)
        {
            StringBuilder stringBuilder = new StringBuilder();
            MD5 md5MemberId = MD5.Create();
            byte[] data = md5MemberId.ComputeHash(Encoding.Default.GetBytes(str));
            for (int i = 0; i < data.Length; ++i)
            {
                stringBuilder.Append(data[i].ToString("x2"));
            }
            return stringBuilder.ToString();
        }
        private DataTable GetDataTable(MySqlConnection connection, string selectString)
        {
            MySqlDataAdapter adapter = new MySqlDataAdapter();
            adapter.SelectCommand = new MySqlCommand(selectString, connection);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            return dataSet.Tables[0];
        }

        [JsonRpcMethod]
        public object LoginRequest(string login, string password, bool remember)
        {
            Hashtable hashtable = new Hashtable();

            if (login.Length == 0 || password.Length == 0)
            {
                hashtable["success"] = false;
                return hashtable;
            }

            string selectShortId = StringToMD5(login);
            string selectString = "SELECT * FROM members WHERE memberShortId='" + selectShortId + "'";
            MySqlConnection connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["Empire"].ConnectionString);
            DataTable selectTable = GetDataTable(connection, selectString);
            if (selectTable.Rows.Count == 0)
            {
                hashtable["success"] = false;
                connection.Close();
                return hashtable;
            }

            if (selectTable.Rows[0]["password"].ToString() == password)
            {
                string stringTicket = StringToMD5(DateTime.Now.ToString ());
                string selectTicket = "SELECT * FROM tickets WHERE memberShortId='" + selectShortId + "'";
                selectTable = GetDataTable(connection, selectTicket);
                if (selectTable.Rows.Count != 0)
                {
                    hashtable["success"] = false;
                    connection.Close();
                    return hashtable;
                }
                string stringInsert = "INSERT INTO tickets VALUES('" + stringTicket + "'," + "'" + selectShortId + "',NULL" + ")";
                MySqlCommand command = new MySqlCommand(stringInsert);
                command.Connection = connection;
                connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();

                hashtable["success"] = true;
                hashtable["ticket"] = stringTicket;
            }
            else
            {
                hashtable["success"] = false;
                connection.Close();
                return hashtable;
            }
            
            connection.Close();

            return hashtable;
        }

        [JsonRpcMethod]
        public object GetMemberInfo(int ticket)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["memberID"] = "qwertqqwes";

            return hashtable;
        }

        [JsonRpcMethod]
        public object LogoffRequest(int ticket)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            
            return hashtable;
        }

       [JsonRpcMethod]
        public object RegisterRequest(string memberID, string password)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["errorID"] = "qwertqqwes";

            return hashtable;
        }

    
    }
}
