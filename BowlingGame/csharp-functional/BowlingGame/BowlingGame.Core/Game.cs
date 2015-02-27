using System;
using NUnit.Framework;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.CodeDom.Compiler;
using NUnit.Framework.Constraints;
using System.Runtime.Versioning;

namespace Sandbox
{
	public class Game
	{
		List<Frame> results = new List<Frame>();

		public void Roll(params int[] pins) {
			var frame = new Frame(pins);
			results.Add(frame);
		}

		public int Score() {
			var game = EndGame();
			return ConvertToTries(game).ToScoringGroups().Take(10).Sum(f => f.Sum());
		}

		private IEnumerable<Frame> EndGame() {
			foreach (var frame in results)
				yield return frame;

			int frames = results.Count;
			while (frames < 11) {
				yield return Frame.Empty;
			}
		}

		private IEnumerable<int> ConvertToTries(IEnumerable<Frame> frames) {
			return frames.SelectMany(f => f.Tries());
		}
	}

	class Frame
	{
		public static Frame Empty = new Frame(0, 0);

		List<int> results = new List<int>();

		public Frame(params int[] tries) {
			results.AddRange(tries);
		}

		public IEnumerable<int> Tries() {
			return results.AsEnumerable();
		}
	}

	public static class BowlingFrameExtensions {
		public static IEnumerable<IEnumerable<int>> ToScoringGroups(this IEnumerable<int> list) {
			yield return list.TakeFrame();

			foreach (var pair in list.SkipFrame().ToScoringGroups()) {
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

