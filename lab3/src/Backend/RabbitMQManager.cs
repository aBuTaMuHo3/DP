using System;
using System.Text;

using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace Backend
{
    class RabbitMQManager
    {
        IModel _model;
        public RabbitMQManager()
        {
            ConnectionFactory factory = new ConnectionFactory();
            factory.HostName = "localhost";

            IConnection connection = factory.CreateConnection();
            _model = connection.CreateModel();
            _model.QueueDeclare("backend-api", false, false, false, null);
        }

        public void Send(string message)
        {
            byte[] messageBodyBytes = Encoding.UTF8.GetBytes(message);
            _model.BasicPublish("", "backend-api", null, messageBodyBytes);
        }
    }
}