using System;
using System.IO;
using System.Text;

namespace DecoratorDojo.Services
{
	public class OutputCaptor
	{
		public string CaptureTextFromExecuting(Action action)
		{
			var stringBuilder = new StringBuilder();
			var stringWriter = new StringWriter(stringBuilder);
			Console.SetOut(stringWriter);

			action();

			return stringBuilder.ToString();
		}
	}
}