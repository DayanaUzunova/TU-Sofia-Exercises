using System;
namespace _2ra
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double weightShipment = double.Parse(Console.ReadLine());
            string service = Console.ReadLine();
            double length = double.Parse(Console.ReadLine());

            double allPrice = 0.0;

            switch (service)
            {
                case "standard":
                    if (weightShipment < 1)
                    {
                        allPrice = length * 0.03;
                    }
                    else if (weightShipment >= 1 && weightShipment <= 10)
                    {
                        allPrice = length * 0.05;
                    }
                    else if (weightShipment >= 11 && weightShipment <= 40)
                    {
                        allPrice = length * 0.10;
                    }
                    else if (weightShipment >= 41 && weightShipment <= 90)
                    {
                        allPrice = length * 0.15;
                    }
                    else if (weightShipment >= 91 && weightShipment <= 150)
                    {
                        allPrice = length * 0.20;
                    }
                    break;

                case "express":
                    if (weightShipment < 1)
                    {
                        allPrice = length * (0.03 + (0.03 * 0.8 * weightShipment));
                    }
                    else if (weightShipment >= 1 && weightShipment <= 10)
                    {
                        allPrice = length * (0.05 + (0.05 * 0.4 * weightShipment));
                    }
                    else if (weightShipment >= 11 && weightShipment <= 40)
                    {
                        allPrice = length * (0.10 + (0.10 * 0.05 * weightShipment));
                    }
                    else if (weightShipment >= 41 && weightShipment <= 90)
                    {
                        allPrice = length * (0.15 + (0.15 * 0.02 * weightShipment));
                    }
                    else if (weightShipment >= 91 && weightShipment <= 150)
                    {
                        allPrice = length * (0.20 + (0.20 * 0.01 * weightShipment));
                    }
                    break;
            }  

            Console.WriteLine("The delivery of your shipment with weight of {0:f3} kg. would cost {1:f2} lv.", weightShipment, allPrice);
        }
    }
    }