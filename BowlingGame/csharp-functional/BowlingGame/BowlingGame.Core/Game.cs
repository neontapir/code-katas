using System;
using NUnit.Framework;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace Sandbox
{
	public class Game
	{
		List<int> results = new List<int>();

		public void Roll(int pins) {
			results.Add(pins);
		}

		public int Score() {
			return results.EndGame().ToFrames().Take(10).Sum(f => f.Sum());
		}
	}

	public static class BlowingFrameExtensions {
		public static IEnumerable<IEnumerable<int>> ToFrames(this IEnumerable<int> list) {
			yield return list.TakeFrame();

			foreach (var pair in list.SkipFrame().ToFrames()) {
				yield return pair;
			}
		}

		public static IEnumerable<int> TakeFrame(this IEnumerable<int> list) {
			return list.Take(list.NumberToTake());
		}

		public static int NumberToTake(this IEnumerable<int> list) {
			if (IsSpare(list) || IsStrike(list))
				return 3;
			return 2;
		}
			
		public static IEnumerable<int> SkipFrame(this IEnumerable<int> list) {
			return list.Skip(list.NumberToSkip());
		}

		public static int NumberToSkip(this IEnumerable<int> list) {
			if (IsStrike(list))
				return 1;
			return 2;
		}

		public static bool IsSpare(IEnumerable<int> list) {
			return (list.Take(2).Sum() == 10);
		}

		public static bool IsStrike(IEnumerable<int> list) {
			return (list.First() == 10);
		}

		public static IEnumerable<int> EndGame(this IEnumerable<int> list) {
			return list.Concat(new int[20]).Take(21);
		}
	}
}

