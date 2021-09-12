#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *Fd, *Thetad, *Phid, *gamd;
	const double *F, *Theta, *Phi, *gam;
	double *Fnew;
	int n;

	if (nrhs != 4)
		mexErrMsgTxt("usage: Fnew = Apply_Gamma_Surf_Closed(F,Theta,Phi,gam)");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]) || !mxIsDouble(prhs[3]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[3]) != 3)
		mexErrMsgTxt("First and last arguments expected to be three dimensional.");

	if (mxGetNumberOfDimensions(prhs[1]) != 2 || mxGetNumberOfDimensions(prhs[2]) != 2)
		mexErrMsgTxt("Second and third arguments expected to be matrices.");

	Fd = mxGetDimensions(prhs[0]);
	Thetad = mxGetDimensions(prhs[1]);
	Phid = mxGetDimensions(prhs[2]);
	gamd = mxGetDimensions(prhs[3]);

	if (Fd[0] != Fd[1] || Thetad[0] != Thetad[1] || Phid[0] != Phid[1] || gamd[0] != gamd[1])
		mexErrMsgTxt("Expected square arguments in first two dimensions.");

	if (Fd[2] != 3)
		mexErrMsgTxt("First argument expected to have third dimension of 3.");

	if (Fd[0] != Thetad[0])
		mexErrMsgTxt("Dimension mismatch between first and second arguments.");

	if (Fd[0] != Phid[0])
		mexErrMsgTxt("Dimension mismatch between first and third arguments.");

	if (Fd[0] != gamd[0])
		mexErrMsgTxt("Dimension mismatch between first and last arguments.");

	if (gamd[2] != 2)
		mexErrMsgTxt("Last argument expected to have third dimension of 2.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	plhs[0] = mxCreateNumericArray(3,Fd,mxDOUBLE_CLASS,mxREAL);

	Fnew = mxGetPr(plhs[0]);
	F = mxGetPr(prhs[0]);
	Theta = mxGetPr(prhs[1]);
	Phi = mxGetPr(prhs[2]);
	gam = mxGetPr(prhs[3]);
	n = Fd[0];

	Apply_Gamma_Surf_Closed(Fnew,F,Theta,Phi,gam,n);
}
