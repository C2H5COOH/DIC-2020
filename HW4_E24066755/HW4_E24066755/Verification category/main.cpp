#include <fstream>
#include <string>
#include <opencv2/opencv.hpp>

using namespace cv;
using namespace std;

void pepperSalt(Mat srcImg, Mat &dstImg, int count, int size);
int QuickSortOnce(uint8_t a[], int low, int high);
void QuickSort(uint8_t a[], int low, int high);
int EvaluateMedian(uint8_t a[], int n);

int main(int argc, char const *argv[]) {
	
	fstream img;
	fstream golden;

	string imageName = "./image.jpg";
	Mat image;
	image = imread(imageName, 1);

	Mat gray_image;
	cvtColor(image, gray_image, CV_RGB2GRAY);
	gray_image.convertTo(gray_image, CV_8U,1,0);

	Mat resize_image;
	Size dsize = Size(128,128);
	resize(gray_image, resize_image, dsize, 0, 0, INTER_LINEAR);

	Mat p_s_image;
	pepperSalt(resize_image, p_s_image, 327, 1);

	uint8_t pad_image[130][130];
	for (int x = 0; x < 130; x++) {
		for (int y = 0; y < 130; y++) {
			if ((x == 0) || (x == 129) || (y == 0) || (y == 129))
				pad_image[x][y] = 255;
			else
				pad_image[x][y] = p_s_image.at<uint8_t>(x-1, y-1);
		}
	}

	uint8_t out_8t[128][128];
	uint8_t mask[9];
	int median = 0;
	for (int y = 1; y < 129; y++) {
		for (int x = 1; x < 129; x++) {
			mask[0] = (pad_image[x - 1][y - 1]);
			mask[1] = (pad_image[x][y - 1]);
			mask[2] = (pad_image[x + 1][y - 1]);
			mask[3] = (pad_image[x - 1][y]);
			mask[4] = (pad_image[x][y]);
			mask[5] = (pad_image[x + 1][y]);
			mask[6] = (pad_image[x - 1][y + 1]);
			mask[7] = (pad_image[x][y + 1]);
			mask[8] = (pad_image[x + 1][y + 1]);

			median = EvaluateMedian(mask, 9);
			out_8t[x-1][y-1] = uint8_t(median);
		}
	}
	Mat out_image(128, 128, CV_8U, out_8t);

	img.open("img.dat", ios::out);
	for (int y = 0; y < 128; y++) {
		for (int x = 0; x < 128; x++) {
			img << hex << int(p_s_image.at<uint8_t>(x,y));
			img << endl;
		}
	}

	golden.open("golden.dat", ios::out);
	for (int y = 0; y < 128; y++) {
		for (int x = 0; x < 128; x++) {
			golden << hex << int(out_image.at<uint8_t>(x, y));
			golden << endl;
		}
	}

	img.close();
	golden.close();

	return 0;
}

void pepperSalt(Mat srcImg, Mat &dstImg, int count, int size)
{
	dstImg.create(srcImg.size(), srcImg.type());
	dstImg = srcImg;
	int xPosition;
	int yPosition;
	int psNoise;
	while (count)
	{
		xPosition = rand() % (srcImg.rows - size + 1);
		yPosition = rand() % (srcImg.cols - size + 1);
		psNoise = rand() % 2;
		if (psNoise)                                     // Create salt spots
			for (int i = 0; i < size; i++)
			{
				for (int j = 0; j < size; j++)
				{
					dstImg.at<uchar>(xPosition + i, yPosition + j) = 255;
				}
			}
		else                                            // Generate hot spots
			for (int i = 0; i < size; i++)
			{
				for (int j = 0; j < size; j++)
				{
					dstImg.at<uchar>(xPosition + i, yPosition + j) = 0;
				}
			}
		count = count - 1;
	}
}

int QuickSortOnce(uint8_t a[], int low, int high) {
	int pivot = a[low];
	int i = low, j = high;

	while (i < j) {
		while (a[j] >= pivot && i < j) {
			j--;
		}
		a[i] = a[j];

		while (a[i] <= pivot && i < j) {
			i++;
		}
		a[j] = a[i];
	}

	a[i] = pivot;

	return i;
}

void QuickSort(uint8_t a[], int low, int high) {
	if (low >= high) {
		return;
	}

	int pivot = QuickSortOnce(a, low, high);

	QuickSort(a, low, pivot - 1);
	QuickSort(a, pivot + 1, high);
}

int EvaluateMedian(uint8_t a[], int n) {
	QuickSort(a, 0, n - 1);

	if (n % 2 != 0) {
		return a[n / 2];
	}
	else {
		return (a[n / 2] + a[n / 2 - 1]) / 2;
	}
}