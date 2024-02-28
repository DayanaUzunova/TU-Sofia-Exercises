namespace Ex_2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double deliveryWeightKg = double.Parse(Console.ReadLine());
            string type = Console.ReadLine();
            int distance = int.Parse(Console.ReadLine());

            double totalSum = 0.0;

            switch (type)
            {
                case "standard":
                    if (deliveryWeightKg < 1)
                    {
                        totalSum = distance * 0.03;
                    }
                    else if (deliveryWeightKg >= 1 && deliveryWeightKg <= 10)
                    {
                        totalSum = deliveryWeightKg * 0.05;
                    }
                    else if (deliveryWeightKg >= 11 && deliveryWeightKg <= 40)
                    {
                        totalSum = distance * 0.10;
                    }
                    else if (deliveryWeightKg >= 41 && deliveryWeightKg <= 90)
                    {
                        totalSum = distance * 0.15;
                    }
                    else if (deliveryWeightKg >= 91 && deliveryWeightKg <= 150)
                    {
                        totalSum = distance * 0.20;
                    }
                    break;
                case "express":
                    if (deliveryWeightKg < 1)
                    {
                        totalSum = distance * (0.03 + (0.03 * 0.8 * deliveryWeightKg));
                    }
                    else if (deliveryWeightKg >= 1 && deliveryWeightKg <= 10)
                    {
                        totalSum = distance * (0.05 + (0.05 * 0.4 * deliveryWeightKg));
                    }
                    else if (deliveryWeightKg >= 11 && deliveryWeightKg <= 40)
                    {
                        totalSum = distance * (0.10 + (0.10 * 0.05 * deliveryWeightKg));
                    }
                    else if (deliveryWeightKg >= 41 && deliveryWeightKg <= 90)
                    {
                        totalSum = distance * (0.15 + (0.15 * 0.02 * deliveryWeightKg));
                    }
                    else if (deliveryWeightKg >= 91 && deliveryWeightKg <= 150)
                    {
                        totalSum = distance * (0.20 + (0.20 * 0.01 * deliveryWeightKg));
                    }
                    break;
            }
            Console.WriteLine($"The delivery of your shipment with weight of {0:f3} kg. would cost {1:f2} lv.");
        }
    }
}