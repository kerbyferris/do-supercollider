Server.default = s = Server.internal.boot

play({SinOsc.ar(LFNoise0.kr(12, mul: 600, add: 1000), 0.3)})

play({RLPF.ar(Dust.ar([12, 15]), LFNoise1.ar(1/[3, 4], 1500, 1600), 0.02)})

play({
	var sines = 2, speed = 6;
	Mix.fill(sines,
		{arg x;
			Pan2.ar(
				SinOsc.ar(x+1*100,
					mul: max(0,
						LFNoise0.kr(speed) +
						Line.kr(1, -1, 30)
			)
), rand2(1.0))})/sines})


(
play(
	{
		CombN.ar(
			SinOsc.ar(
				midicps(
					LFNoise0.ar(3, 24,
						LFSaw.ar([5, 5.123], 0, 3, 80)
					)
				),
				0, 0.4),
			1, 0.3, 2)
	}
)
)

{Blip.ar(25, LFNoise0.kr(5, 12, 14), 0.3)}.play
{Blip.ar(25, LFNoise0.kr([5, 10], 12, 14), 0.3)}.play

{PMOsc.ar(440, 550, 7)}.play
{PMOsc.ar(440, MouseY.kr(1, 550), MouseX.kr(1, 15))}.play

(
{
	Blip.ar(
		TRand.kr( // frequency or VCO
			100, 1000, // range
			Impulse.kr(Line.kr(1, 20, 60))), // trigger
		TRand.kr( // number of harmonics or VCF
			1, 10, // range
			Impulse.kr(Line.kr(1, 20, 60)), // trigger
			0, // attack
			0.5, // sustain level
			1/Line.kr(1, 20, 60)) // trigger
	)
}.play
)

(
{ // carrier and modulator not linked
	r = Impulse.kr(10);
	c = TRand.kr(100, 5000, r);
	m = TRand.kr(100, 5000, r);
	PMOsc.ar(c, m, 12)*0.3
}.play
)

(
{
	var rate = 4, carrier, modRatio; // declare variables
	carrier = LFNoise0.kr(rate) * 500 + 700;
	modRatio = MouseX.kr(1, 2.0);
	// modulator expressed as ratio, therefore timbre
	PMOsc.ar(carrier, carrier*modRatio, 12)*0.3
}.play
)

(
SynthDef("one_tone_only", {
	var out, freq = 440;
	out = SinOsc.ar(freq);
	Out.ar(0, out)
}).add // make sure SuperCollider knows about this SynthDef
)
// then use it to create a running Synth
Synth("one_tone_only")

(
SynthDef("different_tones", {
	arg freq = 432; // declare an argument and give it a default value
	var out;
	out = SinOsc.ar(freq)*0.3;
	Out.ar(0, out)
}).play
)
Synth("different_tones", ["freq", 550]);

a = Synth("different_tones", ["freq", 64.midicps]);
b = Synth("different_tones", ["freq", 67.midicps]);
a.set("freq", 65.midicps);
a.set("freq", 65.midicps);

a.free;
b.free;
