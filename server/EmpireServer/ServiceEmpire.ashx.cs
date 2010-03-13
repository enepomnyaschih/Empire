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
        private string GuidTo32(string guid)
        {
            return guid.Replace("-", "");
        }

        [JsonRpcMethod]
        public object LoginRequest(string login, string password, bool remember)
        {

            Hashtable hashtable = new Hashtable();
            MySqlConnection connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["Empire"].ConnectionString);

            if (login.Length == 0 || password.Length == 0)
            {
                hashtable["success"] = false;
                return hashtable;
            }
            try
            {
                string selectShortId = StringToMD5(login);
                string selectString = "SELECT * FROM members WHERE memberShortId='" + selectShortId + "'";
                DataTable selectTable = GetDataTable(connection, selectString);
                if (selectTable.Rows.Count == 0) throw new Exception();

                if (selectTable.Rows[0]["password"].ToString() == password)
                {
                    string stringTicket = GuidTo32(Guid.NewGuid ().ToString ());
                    string selectTicket = "SELECT * FROM tickets WHERE memberShortId='" + selectShortId + "'";
                    selectTable = GetDataTable(connection, selectTicket);
                    if (selectTable.Rows.Count != 0) throw new Exception();
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
                    throw new Exception();
            }
            catch (Exception)
            {
                hashtable["success"] = false;
                return hashtable;
            }
            finally
            {
                connection.Close();
            }

            return hashtable;
        }

       [JsonRpcMethod]
        public object LogoffRequest(string ticket)
        {
            Hashtable hashtable = new Hashtable();
            MySqlConnection connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["Empire"].ConnectionString);

            if (ticket == "")
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_PM_TICKET";
                return hashtable;
            }

            string selectString = "SELECT * FROM tickets WHERE ticket='" + ticket + "'";
            DataTable selectTable = GetDataTable(connection, selectString);
            if (selectTable.Rows.Count == 0)
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_LOGGED_OFF_ALREADY";
                return hashtable;
            }
            string deleteTicket = "DELETE FROM tickets WHERE ticket='" + ticket + "'";
            MySqlCommand command = new MySqlCommand(deleteTicket);
            command.Connection = connection;
            connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();

            hashtable["success"] = true;

            return hashtable;
        }

        [JsonRpcMethod]
        public object RegisterRequest(string memberId, string password)
        {
            Hashtable hashtable = new Hashtable();
            MySqlConnection connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["Empire"].ConnectionString);

            if (memberId == "")
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_MEMBER_ID_TOO_SHORT";
                return hashtable;
            }
            if (password == "")
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_PASSWORD_TOO_SHORT";
                return hashtable;
            }
            if (memberId.Length < 2)
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_MEMBER_ID_TOO_SHORT";
                return hashtable;
            }
            if (memberId.Length > 30)
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_MEMBER_ID_TOO_LONG";
                return hashtable;
            }
            if (password.Length < 2)
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_PASSWORD_TOO_SHORT";
                return hashtable;
            }
            if (password.Length > 30)
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_PASSWORD_TOO_LONG";
                return hashtable;
            }

            string selectShortId = StringToMD5(memberId);
            string selectString = "SELECT * FROM members WHERE memberShortId='" + selectShortId + "'";
            DataTable selectTable = GetDataTable(connection, selectString);
            if (selectTable.Rows.Count != 0)
            {
                hashtable["success"] = false;
                hashtable["errorId"] = "ERROR_MEMBER_ID_BUSY";
                return hashtable;
            }
            string stringInsert = "INSERT INTO members VALUES('" + selectShortId + "'," + "'" + memberId + "'," + "'" + password + "')";
            MySqlCommand command = new MySqlCommand(stringInsert);
            command.Connection = connection;
            connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
            hashtable["success"] = true;

            return hashtable;
        }

        [JsonRpcMethod]
        public object GetMemberInfo(string ticket)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["memberId"] = "qwertqqwes";

            return hashtable;
        }

        [JsonRpcMethod]
        public object CreateGame(string ticket, string gameName, int maxPlayerCount, int turnDuration)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["gameId"] = GuidTo32(Guid.NewGuid ().ToString ());;

            return hashtable;
        }
    }
}
