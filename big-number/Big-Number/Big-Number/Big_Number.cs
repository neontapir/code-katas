using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Big_Number
{
    public class Big_Number
    {
        private char[] value;

        public Big_Number(IEnumerable<char> v)
        {
            value = v.ToArray();
        }

		public static Big_Number operator +(Big_Number one, Big_Number another)
		{
			return one.Add(another);
		}

		private Big_Number Add(Big_Number another)
		{
			var me = ToString();
			var other = another.ToString();
			int length = Math.Max(me.Length, other.Length);
			me = me.PadLeft(length, '0');
			other = other.PadLeft(length, '0');

			var sb = new StringBuilder();
			int carry = 0;
			for (int i = length - 1; i > -1; i--)
			{
				carry = ComputeDigitSum(me, other, sb, carry, i);
			}
			return new Big_Number(sb.ToString().Reverse().ToArray());
		}

		private int ComputeDigitSum(string me, string other, StringBuilder sb, int carry, int index)
		{
			int x = GetDigit(me, index);
			int y = GetDigit(other, index);
			int sum = x + y + carry;
			if (sum >= 10)
			{
				carry = 1;
				sum -= 10;
			}
			else
			{
				carry = 0;
			}
			sb.Append(sum);
			return carry;
		}

		private int GetDigit(string input, int index)
        {
            return input.Length > index ? Int32.Parse(input[index].ToString()) : 0;
        }

        public override string ToString() => new String(value.ToArray());

		public static bool operator ==(Big_Number one, Big_Number another) {
			return one.Equals(another);
		}

		public static bool operator !=(Big_Number one, Big_Number another)
        {
			return !(one.Equals(another));
        }
        
        public override bool Equals(object obj)
        {
            return (obj is Big_Number) && (ToString() == obj.ToString());
        }

        public override int GetHashCode() => ToString().GetHashCode();
    }
}
