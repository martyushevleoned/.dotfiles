#pragma once

#include <cassert>

template <typename T>
class Result
{
public:
    Result() : m_value(), m_status(false) {};
    Result(const T& value) : m_value(value), m_status(true) {};
    Result(const T& value, bool status) : m_value(value), m_status(status) {};
    operator bool() const
    {
        return m_status;
    };
    const T& get() const
    {
        assert(m_status);
        return m_value;
    };
private:
    const T m_value;
    const bool m_status;
};
