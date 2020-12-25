cimport numpy as np
from libcpp cimport bool
from libcpp.vector cimport vector

# For cv::Mat usage
cdef extern from "core/core.hpp":
  cdef int CV_8UC3
  cdef int CV_32F
  cdef int CV_32FC1

cdef extern from "core/core.hpp" namespace "cv":
  cdef cppclass Mat:
    Mat() except +
    void create(int, int, int)
    void* data
    int rows
    int cols
    int channels()
    int depth()
    size_t elemSize()
    bool empty()

# For Buffer usage
cdef extern from "Python.h":
    ctypedef struct PyObject
    object PyMemoryView_FromBuffer(Py_buffer *view)
    int PyBuffer_FillInfo(Py_buffer *view, PyObject *obj, void *buf, Py_ssize_t len, int readonly, int infoflags)
    enum:
        PyBUF_FULL_RO


# For ORB_SLAM3 usage
cpdef enum eSensor:
  MONOCULAR,
  STEREO,
  RGBD,
  IMU_MONOCULAR,
  IMU_STEREO

cdef extern from "include/System.h" namespace "ORB_SLAM3":
  cdef cppclass System:
    ctypedef enum eSensor:
      MONOCULAR,
      STEREO,
      RGBD,
      IMU_MONOCULAR,
      IMU_STEREO
    System() except +
    System(char*, char*, eSensor, bool, int, char*, char*, Mat) except +
    Mat TrackRGBD(Mat, Mat, double, char*)
    void ActivateLocalizationMode()
    void DeactivateLocalizationMode()
    bool MapChanged()
    void Reset()
    void Reset(Mat)
    void ResetActiveMap()
    void Shutdown()
    void SaveTrajectoryTUM(char*)
    void SaveKeyFrameTrajectoryTUM(char*)
    void SaveTrajectoryEuRoC(char*)
    void SaveKeyFrameTrajectoryEuRoC(char*)
    void SaveDebugData(int)
    void SaveTrajectoryKITTI(char*)
    int GetTrackingState()
    Mat GetWorldPose()
    double GetTimeFromIMUInit()
    bool isLost()
    bool isFinished()
    void ChangeDataset()
