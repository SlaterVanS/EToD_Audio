#include <EToDAudio.h>

#include <thread>
#include <chrono>

using namespace std;

int main()
{
	// Initialize the audio engine
	ETOD::Audio::Init();
	// Load audio source from file
	auto source = ETOD::AudioSource::LoadFromFile("assets/BackgroundMusic.mp3", false);
	// Make it loop forever
	source.SetLoop(true);
	// Play audio source
	ETOD::Audio::Play(source);

	auto frontLeftSource = ETOD::AudioSource::LoadFromFile("assets/FrontLeft.ogg", true);
	frontLeftSource.SetGain(5.0f);
	frontLeftSource.SetPosition(-5.0f, 0.0f, 5.0f);
	ETOD::Audio::Play(frontLeftSource);

	auto frontRightSource = ETOD::AudioSource::LoadFromFile("assets/FrontRight.ogg", true);
	frontRightSource.SetGain(5.0f);
	frontRightSource.SetPosition(5.0f, 0.0f, 5.0f);
	ETOD::Audio::Play(frontRightSource);

	auto movingSource = ETOD::AudioSource::LoadFromFile("assets/Moving.ogg", true);
	movingSource.SetGain(5.0f);
	movingSource.SetPosition(5.0f, 0.0f, 5.0f);

	int sourceIndex = 0;
	const int sourceCount = 3;
	ETOD::AudioSource* sources[] = { &frontLeftSource, &frontRightSource, &movingSource };

	float xPosition = 5.0f;
	float playFrequency = 3.0f; // play sounds every 3 seconds
	float timer = playFrequency;

	chrono::steady_clock::time_point lastTime = chrono::steady_clock::now();
	while (true)
	{
		chrono::steady_clock::time_point currentTime = chrono::steady_clock::now();
		chrono::duration<float> delta = currentTime - lastTime;
		lastTime = currentTime;

		if (timer < 0.0f)
		{
			timer = playFrequency;
			ETOD::Audio::Play(*sources[sourceIndex++ % sourceCount]);
		}

		// Moving sound source
		if (sourceIndex == 3)
		{
			xPosition -= delta.count() * 2.0f;
			movingSource.SetPosition(xPosition, 0.0f, 5.0f);
		}
		else
		{
			xPosition = 5.0f;
		}

		timer -= delta.count();

		using namespace literals::chrono_literals;
		this_thread::sleep_for(5ms);
	}
}