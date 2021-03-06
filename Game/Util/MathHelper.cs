using System;
using Microsoft.Xna.Framework;

namespace Game
{
    public static class CoreMath
    {
        public static void Swap<T>(ref T a, ref T b)
        {
            T temp = a;
            a = b;
            b = temp;
        }
        public static T SwapReturn<T>(ref T a, T b)
        {
            T temp = a;
            a = b;
            return temp;
        }


        public static int Modulo(int n, int p)
        {
            int M = n % p;
            if (M < 0) M += p;
            return M;
        }
        public static float Modulo(float n, float p)
        {
            float M = n - (int)(n / p) * p;
            if (M < 0) M += p;
            return M;
        }
        public static float ZigZag(float period, float t)
        {
            float p = period / 2;
            int n = (int)Math.Floor(t / p);
            t -= n * p;
            if (n % 2 == 0) return t / p;
            else return 1 - t / p;
        }
        public static float PeriodicCentered(float A, float B, float period, float t)
        {
            float Normalized = .5f + .5f * (float)Math.Sin(t * 2 * Math.PI / period);
            return A + (B - A) * Normalized;
        }
        public static float Periodic(float A, float B, float period, float t)
        {
            return Periodic(A, B, period, t, 0);
        }
        public static float Periodic(float A, float B, float period, float t, float PhaseDegree)
        {
            float Normalized = .5f - .5f * (float)Math.Cos(t * 2 * Math.PI / period + CoreMath.Radians(PhaseDegree));
            return A + (B - A) * Normalized;
        }
        public static Vector2 Periodic(Vector2 A, Vector2 B, float period, float t)
        {
            float Normalized = .5f - .5f * (float)Math.Cos(t * 2 * Math.PI / period);
            return A + (B - A) * Normalized;
        }
        public static string Time(int frames)
        {
            int h = Hours(frames);
            int m = Minutes(frames);
            int s = Seconds(frames);
            int mi = Milliseconds(frames);

            //return string.Format("{0:0}h:{1:00}m:{2:00}.{3:00}", h, m, s, mi);
            return string.Format("{0:0}:{1:00}:{2:00}.{3:00}", h, m, s, mi);
        }
        public static string ShortTime(int frames)
        {
            int h = Hours(frames);
            int m = Minutes(frames);
            int s = Seconds(frames);
            int mi = Milliseconds(frames);

            if (h > 0)
                return string.Format("{0:0}:{1:00}:{2:00}.{3:00}", h, m, s, mi);
            else if (m > 0)
                return string.Format("{1:0}:{2:00}", h, m, s, mi);
            else if (s > 10)
                return string.Format("{2:0}.{3:0}", h, m, s, mi / 10);
            else
                return string.Format("{2:0}.{3:00}", h, m, s, mi);
        }
        public static int Hours(int frames)
        {
            return (int)(frames / (60 * 60 * 62));
        }
        public static int Minutes(int frames)
        {
            float Remainder = frames - 60 * 60 * 62 * Hours(frames);
            return (int)(Remainder / (60 * 62));
        }
        public static int Seconds(int frames)
        {
            float Remainder = frames - 60 * 60 * 62 * Hours(frames) - 60 * 62 * Minutes(frames);
            return (int)(Remainder / 62);
        }
        public static int Milliseconds(int frames)
        {
            float Remainder = frames - 60 * 60 * 62 * Hours(frames) - 60 * 62 * Minutes(frames) - 62 * Seconds(frames);
            return (int)(100 * Remainder / 62f);
        }
        /// <summary>
        /// Convert radians to degrees.
        /// </summary>
        public static float Degrees(float Radians)
        {
            return (float)(Radians * 180 / Math.PI);
        }
        /// <summary>
        /// Convert degrees to radians.
        /// </summary>
        public static float Radians(float Degrees)
        {
            return (float)(Degrees * Math.PI / 180);
        }
        public static float c = 180f / (float)Math.PI;
        public static float RadianDist(float a1, float a2)
        {
            return AngleDist(c * a1, c * a2);
        }
        public static float AngleDist(float a1, float a2)
        {
            float dist = Math.Abs(a1 - a2);
            dist = dist % 360f;
            return Math.Min(dist, 360 - dist);
        }
        public static float VectorToAngle(Vector2 v)
        {
            return (float)Math.Atan2(v.Y, v.X);
        }
        public static Vector2 CartesianToPolar(Vector2 v)
        {
            Vector2 polar = new Vector2(VectorToAngle(v),
                                        polar.Y = v.Length());
            return polar;
        }
        public static Vector2 PolarToCartesian(Vector2 v)
        {
            return v.Y * AngleToDir(v.X);
        }
        /// <summary>
        /// Converts an angle in radians to a normalized direction vector.
        /// </summary>
        /// <param name="Angle">The angle in radians.</param>
        /// <returns></returns>
        public static Vector2 AngleToDir(double Angle)
        {
            return new Vector2((float)Math.Cos(Angle), (float)Math.Sin(Angle));
        }
        /// <summary>
        /// Converts an angle in degrees to a normalized direction vector.
        /// </summary>
        /// <param name="Angle">The angle in degrees.</param>
        /// <returns></returns>
        public static Vector2 DegreesToDir(double Angle)
        {
            return AngleToDir(Math.PI / 180f * Angle);
        }
        public static float Snap(float x, float spacing)
        {
            return spacing * (int)(x / spacing);
        }
        public static Vector2 Snap(Vector2 x, Vector2 spacing)
        {
            return new Vector2(Snap(x.X, spacing.X), Snap(x.Y, spacing.Y));
        }
        /// <summary>
        /// Calculate the sup norm of a vector.
        /// </summary>
        /// <param name="v"></param>
        /// <returns></returns>
        public static float SupNorm(Vector2 v)
        {
            return Math.Max(Math.Abs(v.X), Math.Abs(v.Y));
        }
        public static Vector2 Sign(Vector2 v)
        {
            return new Vector2(Math.Sign(v.X), Math.Sign(v.Y));
        }
        public static float Max(params float[] vals)
        {
            float max = vals[0];
            for (int i = 1; i < vals.Length; i++)
                max = Math.Max(max, vals[i]);
            return max;
        }
        /// <summary>
        /// Take in two vectors and find both the max and the min.
        /// </summary>
        public static void MaxAndMin(ref Vector2 p1, ref Vector2 p2, ref Vector2 Max, ref Vector2 Min)
        {
            if (p1.X > p2.X)
            {
                Max.X = p1.X;
                Min.X = p2.X;
            }
            else
            {
                Max.X = p2.X;
                Min.X = p1.X;
            }

            if (p1.Y > p2.Y)
            {
                Max.Y = p1.Y;
                Min.Y = p2.Y;
            }
            else
            {
                Max.Y = p2.Y;
                Min.Y = p1.Y;
            }
        }
        /// <summary>
        /// Returns the component-wise absolute value of the Vector2
        /// </summary>
        public static Vector2 Abs(Vector2 v)
        {
            return new Vector2(Math.Abs(v.X), Math.Abs(v.Y));
        }
        /// <summary>
        /// Checks whether two points are close to each other.
        /// </summary>
        /// <param name="v1">The first point.</param>
        /// <param name="v2">The second point.</param>
        /// <param name="Cutoff">The cutoff range.</param>
        /// <returns></returns>
        public static bool Close(Vector2 v1, Vector2 v2, Vector2 Cutoff)
        {
            if (v1.X > v2.X + Cutoff.X) return false;
            if (v1.X < v2.X - Cutoff.X) return false;
            if (v1.Y > v2.Y + Cutoff.Y) return false;
            if (v1.Y < v2.Y - Cutoff.Y) return false;
            return true;
        }
        public static Vector2 Restrict(float min, float max, Vector2 val)
        {
            val.X = Restrict(min, max, val.X);
            val.Y = Restrict(min, max, val.Y);

            return val;
        }
        /// <summary>
        /// Restrict a value between a min and a max.
        /// </summary>
        public static float Restrict(float min, float max, float val)
        {
            if (val > max) val = max;
            if (val < min) val = min;

            return val;
        }
        public static void Restrict(float min, float max, ref float val)
        {
            val = Restrict(min, max, val);
        }
        /// <summary>
        /// Restrict a value between a min and a max.
        /// </summary>
        public static int Restrict(int min, int max, int val)
        {
            if (val > max) val = max;
            if (val < min) val = min;

            return val;
        }
        public static void Restrict(int min, int max, ref int val)
        {
            val = Restrict(min, max, val);
        }

        /// <summary>
        /// Interpolate between a list of values.
        /// t = 0 returns the first value, t = 1 the second value, etc
        /// </summary>
        public static float MultiLerpRestrict(float t, params float[] values)
        {
            if (t <= 0) return values[0];
            if (t >= values.Length - 1) return values[values.Length - 1];

            int i1 = Math.Min((int)t, values.Length - 1);
            int i2 = i1 + 1;

            return Lerp(values[i1], values[i2], t - i1);
        }
        public static Vector2 MultiLerpRestrict(float t, params Vector2[] values)
        {
            if (t <= 0) return values[0];
            if (t >= values.Length - 1) return values[values.Length - 1];

            int i1 = Math.Min((int)t, values.Length - 1);
            int i2 = i1 + 1;

            return Vector2.Lerp(values[i1], values[i2], t - i1);
        }
        public static int LerpRestrict(int v1, int v2, float t)
        {
            return (int)LerpRestrict((float)v1, (float)v2, t);
        }
        public static int Lerp(int v1, int v2, float t)
        {
            return (int)Lerp((float)v1, (float)v2, t);
        }
        public static float LerpRestrict(float v1, float v2, float t)
        {
            return Lerp(v1, v2, CoreMath.Restrict(0, 1, t));
        }
        public static float Lerp(float v1, float v2, float t)
        {
            return (1 - t) * v1 + t * v2;
        }
        public static Vector2 LerpRestrict(Vector2 v1, Vector2 v2, float t)
        {
            if (t > 1) return v2;
            if (t < 0) return v1;
            return Vector2.Lerp(v1, v2, t);
        }

        /// <summary>
        /// Let f(x) be a linear function such that f(x1) = y1 and f(x2) = y2.
        /// This function returns f(t).
        /// </summary>
        public static float Lerp(float x1, float y1, float x2, float y2, float t)
        {
            float width = x2 - x1;
            float s = (t - x1) / width;

            return y2 * s + y1 * (1 - s);
        }
        public static float LerpRestrict(float x1, float y1, float x2, float y2, float t)
        {
            return Restrict(Math.Min(y1, y2), Math.Max(y1, y2), Lerp(x1, y1, x2, y2, t));
        }

        public static float LogLerpRestrict(float x1, float y1, float x2, float y2, float t)
        {
            t  = (float)Math.Log(t);
            x1 = (float)Math.Log(x1);
            x2 = (float)Math.Log(x2);

            return Restrict(Math.Min(y1, y2), Math.Max(y1, y2), Lerp(x1, y1, x2, y2, t));
        }

        public static float SmoothLerp(float v1, float v2, float t)
        {
            return FancyLerp(t, new float[] { 
                CoreMath.Lerp(v1, v2, 0),
                CoreMath.Lerp(v1, v2, 0.5f),
                CoreMath.Lerp(v1, v2, 0.75f),
                CoreMath.Lerp(v1, v2, 0.875f),
                CoreMath.Lerp(v1, v2, 0.9375f),
                CoreMath.Lerp(v1, v2, 1) });
        }
        public static float FancyLerp(float t, float[] keyframes)
        {
            if (t >= 1) return keyframes[keyframes.Length - 1];
            if (t <= 0) return keyframes[0];

            float _t = keyframes.Length * t;
            int frame = (int)(_t);

            var v1 = frame > 0 ? keyframes[frame - 1] : keyframes[0];
            var v2 = keyframes[frame];
            var v3 = frame + 1 < keyframes.Length ? keyframes[frame + 1] : keyframes[keyframes.Length - 1];
            var v4 = frame + 2 < keyframes.Length ? keyframes[frame + 2] : keyframes[keyframes.Length - 1];

            //return Vector2.CatmullRom(v1, v2, v3, v4, _t - frame);
            //return Vector2.Hermite(v2, v2 - v1, v3, v4 - v3, _t - frame);
            return Lerp(v2, v3, _t - frame);
        }
        public static Vector2 FancyLerp(float t, Vector2[] keyframes)
        {
            if (t >= 1) return keyframes[keyframes.Length - 1];
            if (t <= 0) return keyframes[0];

            float _t = keyframes.Length * t;
            int frame = (int)(_t);

            var v1 = frame > 0 ? keyframes[frame - 1] : keyframes[0];
            var v2 = keyframes[frame];
            var v3 = frame + 1 < keyframes.Length ? keyframes[frame + 1] : keyframes[keyframes.Length - 1];
            var v4 = frame + 2 < keyframes.Length ? keyframes[frame + 2] : keyframes[keyframes.Length - 1];

            //return Vector2.CatmullRom(v1, v2, v3, v4, _t - frame);
            //return Vector2.Hermite(v2, v2 - v1, v3, v4 - v3, _t - frame);
            return Vector2.Lerp(v2, v3, _t - frame);
        }
        public static float ParabolaInterp(float t, Vector2 apex, float zero1)
        {
            float q = (float)Math.Pow(zero1 - apex.X, 2);
            return apex.Y * (float)(q - Math.Pow(t - apex.X, 2)) / q;
        }
        public static float ParabolaInterp(float t, Vector2 apex, float zero1, float power)
        {
            float q = (float)Math.Pow(Math.Abs(zero1 - apex.X), power);
            return apex.Y * (float)(q - Math.Pow(Math.Abs(t - apex.X), power)) / q;
        }

        public static Vector2 Reciprocal(Vector2 v)
        {
            return new Vector2(v.Y, -v.X);
        }
        public static void RotatedBasis(float Degrees, ref Vector2 v)
        {
            Vector2 e1 = CoreMath.DegreesToDir(Degrees);
            Vector2 e2 = CoreMath.DegreesToDir(Degrees + 90);

            v = v.X * e1 + v.Y * e2;
        }

        public static double ParseDouble(string s)
        {
            var style = System.Globalization.NumberStyles.Float;

            try
            {
                return (float)double.Parse(s, style);
            }
            catch (Exception e1)
            {
                try
                {
                    return (float)double.Parse(s.Replace('.', ','), style);
                }
                catch (Exception e2)
                {
                    try
                    {
                        return (float)double.Parse(s.Replace(',', '.'), style);
                    }
                    catch (Exception e3)
                    {
                        return 0;
                    }
                }
            }
        }

        public static float ParseFloat(string s)
        {
            var style = System.Globalization.NumberStyles.Float;

            try
            {
                return (float)float.Parse(s, style);
            }
            catch (Exception e1)
            {
                try
                {
                    return (float)float.Parse(s.Replace('.', ','), style);
                }
                catch (Exception e2)
                {
                    try
                    {
                        return (float)float.Parse(s.Replace(',', '.'), style);
                    }
                    catch (Exception e3)
                    {
                        return 0;
                    }
                }
            }
        }
    }
}