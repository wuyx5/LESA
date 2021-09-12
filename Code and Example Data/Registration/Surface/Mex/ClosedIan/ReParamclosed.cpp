#include <cstring>
#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *f1d, *f2newd, *A_tmp21d, *A_tmp22newd, *bd, *gampd, *gamidd, *Thetad, *Phid, *Psid;
	int n, t, a, itermax, niter;
	const double *f1, *f2new, *Snorm1, *Snorm2, *A_tmp21, *A_tmp22new, *b, *gamp, *gamid, *Theta, *Phi, *Psi;
	double *Fnew, *H, *gampnew, eps;

	if (nrhs != 17)
		mexErrMsgTxt("usage: [Fnew,H,gamp,iter1,A] = ReParamclosed(f1,f2new,Snorm1,Snorm2,A_tmp21,A_tmp22new,b,gamp,gamid,Theta,Phi,Psi,iter1,A,winsize,itermax,eps)");
/*
	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]) || !mxIsDouble(prhs[3]) ||
		!mxIsDouble(prhs[4]) || !mxIsDouble(prhs[5]) || !mxIsDouble(prhs[6]) || !mxIsDouble(prhs[7]) ||
		!mxIsDouble(prhs[8]) || !mxIsDouble(prhs[9]) || !mxIsDouble(prhs[13]) || !mxIsDouble(prhs[14])) {
		mexErrMsgTxt("Expected double precision arguments.");
	}

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[1]) != 3 || 
		mxGetNumberOfDimensions(prhs[5]) != 3 || mxGetNumberOfDimensions(prhs[6]) != 3 ||
		mxGetNumberOfDimensions(prhs[9]) != 3) {
		mexErrMsgTxt("First, second, sixth, seventh, and tenth arguments expected to be three dimensional.");
	}

	if (mxGetNumberOfDimensions(prhs[2]) != 2 || mxGetNumberOfDimensions(prhs[3]) != 2 ||
		mxGetNumberOfDimensions(prhs[7]) != 2 || mxGetNumberOfDimensions(prhs[8]) != 2) {
		mexErrMsgTxt("Third, fourth, eighth, and ninth arguments expected to be matrices.");
	}

	if (mxGetNumberOfDimensions(prhs[4]) != 4)
		mexErrMsgTxt("Fifth argument expected to be four dimensional.");

	if (mxGetNumberOfElements(prhs[13]) != 1 || mxGetNumberOfElements(prhs[14]) != 1)
		mexErrMsgTxt("Fourteenth and fifteenth arguments expected to be scalars.");
*/
	f1d = mxGetDimensions(prhs[0]);
	f2newd = mxGetDimensions(prhs[1]);
	A_tmp21d = mxGetDimensions(prhs[4]);
	A_tmp22newd = mxGetDimensions(prhs[5]);
	bd = mxGetDimensions(prhs[6]);
	gampd = mxGetDimensions(prhs[7]);
	gamidd = mxGetDimensions(prhs[8]);
	Thetad = mxGetDimensions(prhs[9]);
	Phid = mxGetDimensions(prhs[10]);
	Psid = mxGetDimensions(prhs[11]);

	if (f1d[0] != f1d[1] || f2newd[0] != f2newd[1] || A_tmp21d[0] != A_tmp21d[1] ||
		A_tmp22newd[0] != A_tmp22newd[1] || bd[0] != bd[1] || gampd[0] != gampd[1] ||
		gamidd[0] != gamidd[1] || Thetad[0] != Thetad[1] || Phid[0] != Phid[1] ||
		Psid[0] != Psid[1]) {
		mexErrMsgTxt("All high dimensional arguments expected to have square dimensions in first two dimensions.");
	}

	if (f1d[0] != f2newd[0] || f1d[0] != A_tmp21d[0] || f1d[0] != A_tmp22newd[0] ||
		f1d[0] != bd[0] || f1d[0] != gampd[0] || f1d[0] != gamidd[0] || f1d[0] != Thetad[0] ||
		f1d[0] != Phid[0] || f1d[0] != Psid[0]) {
		mexErrMsgTxt("All high dimensional arguments expected to have matching first two dimensions.");
	}

/*
	if (f1d[2] != 3 || f2newd[2] != 3)
		mexErrMsgTxt("First two arguments expected to have a third dimension of 3.");

	if (bd[2] != 2 || gampd[2] != 2 || gamidd[2] != 2)
		mexErrMsgTxt("Fifth, sixth, and seventh arguments expected to have third dimension of 2.");

	if (2*Psid[2] != bd[3])
		mexErrMsgTxt("Dimension 3 of argument ten expected to be twice dimension 4 of argument five.");

	if (nlhs != 5)
		mexErrMsgTxt("Expected five returns.");
*/

	n = f1d[0];
	t = f1d[1];
	a = bd[3];

	plhs[0] = mxCreateNumericArray(3,f1d,mxDOUBLE_CLASS,mxREAL);
	plhs[2] = mxCreateNumericArray(3,gampd,mxDOUBLE_CLASS,mxREAL);
	plhs[3] = mxDuplicateArray(prhs[12]);
	plhs[4] = mxDuplicateArray(prhs[13]);

	Fnew = mxGetPr(plhs[0]);
	gampnew = mxGetPr(plhs[2]);
	f1 = mxGetPr(prhs[0]);
	f2new = mxGetPr(prhs[1]);
	Snorm1 = mxGetPr(prhs[2]);
	Snorm2 = mxGetPr(prhs[3]);
	A_tmp21 = mxGetPr(prhs[4]);
	A_tmp22new = mxGetPr(prhs[5]);
	b = mxGetPr(prhs[6]);
	gamp = mxGetPr(prhs[7]);
	gamid = mxGetPr(prhs[8]);
	Theta = mxGetPr(prhs[9]);
	Phi = mxGetPr(prhs[10]);
	Psi = mxGetPr(prhs[11]);
	itermax = (int)mxGetScalar(prhs[15]);
	eps = mxGetScalar(prhs[16]);

	H = new double[itermax+1];

	niter = ReParamclosed(Fnew,H,gampnew,f1,f2new,Snorm1,Snorm2,A_tmp21,A_tmp22new,b,gamp,gamid,Theta,Phi,Psi,itermax,eps,n,t,a);

	if (niter < 1) {
		delete [] H;
		mexErrMsgTxt("ERROR: The step size is too large.");
	}

	mexPrintf("Took %d iterations.\n", niter);

	plhs[1] = mxCreateDoubleMatrix(1,niter+1,mxREAL);
	memcpy(mxGetPr(plhs[1]),H,(niter+1)*sizeof(double));

	delete [] H;
}
