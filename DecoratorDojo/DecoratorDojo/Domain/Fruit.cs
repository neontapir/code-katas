using System;
using System.IO;

namespace DecoratorDojo.Domain
{
	public abstract class Food
	{
		public string Name { get; protected set; }

		public virtual void Eat()
		{
			Console.WriteLine("Ate the " + Name);
		}
	}

	public abstract class Fruit : Food
	{
		protected Fruit(string name)
		{
			Name = name;
		}
	}
}
