using System;

namespace TextListener
{
    class Program
    {
        static void Main(string[] args)
        {
            RabbitMQManager rabbitMQManager = new RabbitMQManager();
            rabbitMQManager.Receive();
        }
    }
}
