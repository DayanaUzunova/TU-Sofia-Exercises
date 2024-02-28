using System;
using System.Numerics;

namespace ex1
{
    class Program
    {
        static void Main(string[] args)
        {
            double tShirtPrice = double.Parse(Console.ReadLine());
            double priceForWin = double.Parse(Console.ReadLine());

            double shortsPrice = 0.75 * tShirtPrice;
            double socksPrice = 0.2 * shortsPrice;

            double shoes = 2 * (tShirtPrice + shortsPrice);

            double sum = tShirtPrice + shortsPrice + socksPrice + shoes;
            double sumWithDiscount = sum - (sum * 0.15);

            if (sumWithDiscount >= priceForWin) {
                Console.WriteLine("Yes, he will earn the world-cup replica ball!");
                Console.WriteLine($"His sum is {sumWithDiscount:f2} lv.", sumWithDiscount);
                   
                    }
            else
            {
                Console.WriteLine("No, he will not earn the world-cup replica ball.");
                Console.WriteLine($"He needs {priceForWin - sumWithDiscount:f2} lv. more.", priceForWin - sumWithDiscount);
            }

        }
    }
}
